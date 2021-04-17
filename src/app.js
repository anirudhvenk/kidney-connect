App = {
    contracts: {},
    load: async () => {
        await App.loadWeb3()
        await App.loadAccount()
        await App.loadContract()
        await App.render()
    },

    loadWeb3: async () => {
        if (typeof web3 !== 'undefined') {
            App.web3Provider = web3.currentProvider
            web3 = new Web3(web3.currentProvider)
        } else {
            window.alert("Please connect to Metamask.")
        }
        // Modern dapp browsers...
        if (window.ethereum) {
            window.web3 = new Web3(ethereum)
            try {
                // Request account access if needed
                await ethereum.enable()
                // Acccounts now exposed

                web3.eth.sendTransaction({/* ... */ })
            } catch (error) {
                // User denied account access...
            }
        }
        // Legacy dapp browsers...
        else if (window.web3) {
            App.web3Provider = web3.currentProvider
            window.web3 = new Web3(web3.currentProvider)
            // Acccounts always exposed
            web3.eth.sendTransaction({/* ... */ })
        }
        // Non-dapp browsers...
        else {
            console.log('Non-Ethereum browser detected. You should consider trying MetaMask!')
        }
    },

    loadAccount: async () => {
        // Set the current blockchain account
        App.account = (await web3.eth.getAccounts())[0]
        console.log(App.account)
    },

    loadContract: async () => {
        // Create a JavaScript version of the smart contract
        const certificateLedger = await $.getJSON('CertificateLedger.json')
        App.contracts.certificateLedger = TruffleContract(certificateLedger)
        App.contracts.certificateLedger.setProvider(App.web3Provider)
        App.contracts.certificateLedger.defaults({ from: App.account });

        // Hydrate the smart contract with values from the blockchain
        App.certificateLedger = await App.contracts.certificateLedger.deployed()
    },

    render: async () => {
        // Prevent double render
        if (App.loading) {
            return
        }

        // Update app loading state
        App.setLoading(true)

        // Render Account
        $('#account').html(App.account)

        // Render Tasks
        // await App.renderTasks()

        // Update loading state
        App.setLoading(false)
    },

    renderTasks: async (donorID, recipientID) => {
        if (donorID || recipientID) {
            document.getElementById('wrapper').style.visibility = 'hidden';
            document.getElementById('create').style.visibility = 'hidden';
            document.getElementById('success').style.visibility = 'visible';
            document.getElementById('success').style.position = 'relative';

            document.getElementById('donorID').innerHTML = `Donor ID: ${donorID}`;
            document.getElementById('recipientID').innerHTML = `Recipient ID: ${recipientID}`;
        } else {
            document.getElementById('wrapper').style.visibility = 'hidden';
            document.getElementById('create').style.visibility = 'hidden';
            document.getElementById('fail').style.visibility = 'visible';
            document.getElementById('fail').style.position = 'relative';
        }
    },

    createTask: async () => {
        // App.setLoading(true)
        const donorID = App.uuidv4()
        const recipientID = App.uuidv4()
        const recipientHealth = {
            age: $('#rage').val(),
            PRA: $('#rpra').val(),
            bloodType: $('#rbloodType').val(),
            HLAA1: $('#rhla-a1').val(),
            HLAA2: $('#rhla-a2').val(),
            HLAB1: $('#rhla-b1').val(),
            HLAB2: $('#rhla-b2').val(),
            HLADR1: $('#rhla-dr1').val(),
            HLADR2: $('#rhla-dr2').val(),
            HLADQ1: $('#rhla-dq1').val(),
            HLADQ2: $('#rhla-dq2').val()
        }
        const donorHealth = {
            age: $('#dage').val(),
            PRA: $('#dpra').val(),
            bloodType: $('#dbloodType').val(),
            HLAA1: $('#dhla-a1').val(),
            HLAA2: $('#dhla-a2').val(),
            HLAB1: $('#dhla-b1').val(),
            HLAB2: $('#dhla-b2').val(),
            HLADR1: $('#dhla-dr1').val(),
            HLADR2: $('#dhla-dr2').val(),
            HLADQ1: $('#dhla-dq1').val(),
            HLADQ2: $('#dhla-dq2').val()
        }


        const splitAt = index => x => [x.slice(0, index), x.slice(index)]


        await App.certificateLedger.createCert(recipientID, donorID, recipientHealth, donorHealth, App.account)
        const match = splitAt(35)(await App.certificateLedger.findMatch(App.account))
        await App.renderTasks(match[0], match[1]);
    },

    uuidv4() {
        return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
            var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
            return v.toString(16);
        });
    },

    // toggleCompleted: async (e) => {
    //     App.setLoading(true)
    //     const taskId = e.target.name
    //     await App.todoList.toggleCompleted(taskId)
    //     window.location.reload()
    // },

    setLoading: (boolean) => {
        App.loading = boolean
        const loader = $('#loader')
        const content = $('#content')
        if (boolean) {
            loader.show()
            content.hide()
        } else {
            loader.hide()
            content.show()
        }
    }
}

$(() => {
    $(window).load(() => {
        App.load()
    })
})