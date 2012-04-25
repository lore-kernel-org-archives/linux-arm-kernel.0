From: stigge@antcom.de (Roland Stigge)
Date: Wed, 25 Apr 2012 14:15:06 +0200
Subject: [PATCHv4 1/2] drivers: input: keypad: Add device tree support
In-Reply-To: <CAKdam57H-JH_vgohMo6Mp3jF46irBJJphj-bHc8SBZUXv564Ug@mail.gmail.com>
References: <1335346004-18108-1-git-send-email-sourav.poddar@ti.com>
 <20120425105235.GV24211@n2100.arm.linux.org.uk> <4F97E243.1040707@antcom.de>
 <CAKdam57H-JH_vgohMo6Mp3jF46irBJJphj-bHc8SBZUXv564Ug@mail.gmail.com>
Message-ID: <4F97EACA.9070603@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On 04/25/2012 01:56 PM, Poddar, Sourav wrote:
> Even I was using the bindings as used by samsung-keypad driver. But according
> to the comments and logically too, we should use the common matrix keyboard
> bindings already descibed in
> Documentation/devicetree/bindings/input/matrix-keymap.txt.

Fine with me. Can switch over to
Documentation/devicetree/bindings/input/matrix-keymap.txt

Maybe samsung-keypad should also be converted because it's subnodes
structure duplicates exactly the same thing (row,col,code) in a
different way, and we both were distracted by it, ignoring
matrix-keymap.txt? Or is it already too late (both samsung-keypad and
matrix-keypad both being standards in use) and we should put a
recommendation into one of them to use the other one for new designs?

Thanks,

Roland
