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

    // renderTasks: async () => {
    //     // Load the total task count from the blockchain
    //     const taskCount = await App.todoList.taskCount()
    //     const $taskTemplate = $('.taskTemplate')

    //     // Render out each task with a new task template
    //     for (var i = 1; i <= taskCount; i++) {
    //         // Fetch the task data from the blockchain
    //         const task = await App.todoList.tasks(i)
    //         const taskId = task[0].toNumber()
    //         const taskContent = task[1]
    //         const taskCompleted = task[2]

    //         // Create the html for the task
    //         const $newTaskTemplate = $taskTemplate.clone()
    //         $newTaskTemplate.find('.content').html(taskContent)
    //         $newTaskTemplate.find('input')
    //             .prop('name', taskId)
    //             .prop('checked', taskCompleted)
    //             .on('click', App.toggleCompleted)

    //         // Put the task in the correct list
    //         if (taskCompleted) {
    //             $('#completedTaskList').append($newTaskTemplate)
    //         } else {
    //             $('#taskList').append($newTaskTemplate)
    //         }

    //         // Show the task
    //         $newTaskTemplate.show()
    //     }
    // },

    createTask: async () => {
        // App.setLoading(true)
        const content = $('#newTask').val()
        const donorID = App.uuidv4()
        const recipientID = App.uuidv4()
        const recipientHealth = {
            age: 10
        }

        await App.certificateLedger.createCert(App.account, recipientID, recipientHealth)
        let age = await App.certificateLedger.getRecipientHealth(0)
        console.log(age)
        // window.location.reload()
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