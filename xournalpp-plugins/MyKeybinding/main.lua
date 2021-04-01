function initUi()
  print("Hello from Andreas' example plugin\n");

  ref = app.registerUi({["menu"] = "Select Pen tool", ["callback"] = "select_pen", ["accelerator"] = "1"});
  ref = app.registerUi({["menu"] = "Select Highlighter tool", ["callback"] = "select_highlighter", ["accelerator"] = "2"});
  ref = app.registerUi({["menu"] = "Select Text tool", ["callback"] = "select_text", ["accelerator"] = "3"});
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
