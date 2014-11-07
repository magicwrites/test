child = require 'child_process'
path = require 'path'



rebuild = () ->
    spawned = child.spawn 'touch', ['updated.touched']

    spawned.on 'close', (code) ->
        console.log 'REBUILD EXITED WITH CODE %s', code

checkExecutionDirectory = () ->
    expected = __dirname
    expected = expected.split path.sep
    expected.pop()
    expected = expected.join path.sep

    return expected is process.cwd()

update = () ->
    console.log 'SPAWNING ...'

    spawned = child.spawn 'git', ['pull']

    spawned.stdout.on 'data', (data) ->
        console.log 'STDOUT: \n\n %s', data

        searched = data.toString().search 'up-to-date'
        isUpdated = searched < 0
        if isUpdated then rebuild()

    spawned.stderr.on 'data', (data) ->
        console.log 'STDERR: \n\n %s', data

    spawned.on 'close', (code) ->
        console.log 'EXITED WITH CODE %s', code
        setTimeout update, 2000



if not checkExecutionDirectory() then throw new Error 'script must be ran from project root directory'

do update
