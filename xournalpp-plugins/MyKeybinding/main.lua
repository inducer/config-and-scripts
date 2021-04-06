-- https://xournalpp.github.io/guide/plugins/plugins/
-- 
function initUi()
  -- https://github.com/xournalpp/xournalpp/blob/master/src/control/Control.cpp#L368
  ref = app.registerUi({["menu"] = "Select Pen tool", ["callback"] = "select_pen", ["accelerator"] = "<Control>1"});
  ref = app.registerUi({["menu"] = "Select Highlighter tool", ["callback"] = "select_highlighter", ["accelerator"] = "<Control>2"});
  ref = app.registerUi({["menu"] = "Select Text tool", ["callback"] = "select_text", ["accelerator"] = "<Control>3"});
  ref = app.registerUi({["menu"] = "Select rectangle selection tool", ["callback"] = "select_rect_sel", ["accelerator"] = "<Control>4"});
end

-- Callback if the menu item is executed
function select_pen()
    app.uiAction({["action"]="ACTION_TOOL_PEN"})
end
function select_highlighter()
    app.uiAction({["action"]="ACTION_TOOL_HILIGHTER"})
end
function select_text()
    app.uiAction({["action"]="ACTION_TOOL_TEXT"})
end
function select_rect_sel()
    app.uiAction({["action"]="ACTION_TOOL_SELECT_RECT"})
end
