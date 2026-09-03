--[[

Aug 17, 2026

(Generated and debugged with ChatGPT's assistance)

** Take this plugin with a grain of salt until it's reviewed by an experienced GLua programmer.

]]

local ConsolePrint = Ponder.API.NewInstruction("ConsolePrint") --prints multiline block automatically

function ConsolePrint:First(playback)

    print(self.Text or "")

end


--[[

how to use:

--multiline print example

chapter1:AddInstruction("ConsolePrint", { --start of block
    Text = [[
=== JMod Tutorial ===
Step 1: Place the ore.
Step 2: Process the ore.
Step 3: Collect the output.
Tutorial complete!

]]

--}) end of block here (remove -- from this line otherwise I can't comment here)


--]]


--[[

chapter1:AddInstruction("ConsolePrint", { onee line print example
    Text = "Hello, this is one line!"
})

]]