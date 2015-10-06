module.exports =
  activate: ->
    atom.commands.add 'atom-workspace', 'increment-selection:increment', => @increment()

  increment: ->
    editor = atom.workspace.getActivePaneItem()
    selections = editor.getSelections()

    if selections.length > 1
      text = selections[0].getText()
      start = if isNumeric(text) then +text else 1

      selections.forEach (selection, index) ->
        selection.insertText (start + index).toString()
    else if !selections[0].isEmpty()
      lines = selections[0].getText().split('\n')

      if lines.length > 1
        start = if isNumeric(lines[0]) then +lines[0] else 1

        lines.forEach (line, index) ->
          lines[index] = start + index

        selections[0].insertText lines.join('\n')

isNumeric = (obj) ->
    return !Array.isArray(obj) and (obj - parseFloat(obj) + 1) >= 0;
