def unnarrow(percol):
    try:
        original_index = percol.model.results[percol.model.index][2]
    except IndexError:
        original_index = 0
    percol.command.clear_query()
    percol.model.do_search("")
    percol.model.select_index(original_index)

percol.import_keymap({ "C-f" : unnarrow })
