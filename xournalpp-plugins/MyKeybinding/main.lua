-- https://xournalpp.github.io/guide/plugins/plugins/
-- 
function initUi()
  ref = app.registerUi({["menu"] = "Select Pen tool", ["callback"] = "select_pen", ["accelerator"] = "<Control>1"});
  ref = app.registerUi({["menu"] = "Toggle line", ["callback"] = "toggle_line", ["accelerator"] = "<Control>2"});
  ref = app.registerUi({["menu"] = "Select Text tool", ["callback"] = "select_text", ["accelerator"] = "<Control>3"});
  ref = app.registerUi({["menu"] = "Select rectangle selection tool", ["callback"] = "select_rect_sel", ["accelerator"] = "<Control>4"});
  ref = app.registerUi({["menu"] = "Select Highlighter tool", ["callback"] = "select_highlighter", ["accelerator"] = "<Control>5"});
end

-- Callback if the menu item is executed
-- https://github.com/xournalpp/xournalpp/blob/master/src/control/Control.cpp#L368
function select_pen()
    app.uiAction({["action"]="ACTION_TOOL_PEN"})
    app.uiAction({["action"]="ACTION_RULER", ["enabled"]=false})
end
function toggle_line()
    app.uiAction({["action"]="ACTION_RULER"})
end
function select_text()
    app.uiAction({["action"]="ACTION_TOOL_TEXT"})
end
function select_rect_sel()
    app.uiAction({["action"]="ACTION_TOOL_SELECT_RECT"})
end
function select_highlighter()
    app.uiAction({["action"]="ACTION_TOOL_HILIGHTER"})
end
