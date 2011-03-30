From: tixy@yxit.co.uk (Tixy)
Date: Wed, 30 Mar 2011 14:53:33 +0100
Subject: How to handle kprobe bugs?
Message-ID: <1301493213.2488.41.camel@computer2.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that I'm writing some test code for kprobes I'm quickly finding
further bugs with the instruction emulation. E.g. ALU ops with an
immediate operand are broke. Shall I wait until I have completed writing
all test cases before submitting a single fix patch? (It could be a
couple of weeks.)

I also find that instruction emulation for some (all?) ARMv6K and newer
instructions are missing. E.g. hint instructions like NOP and WFI. Shall
I produce a second patch to add these?

At some point I will also get around to doing my original task of adding
Thumb support to kprobes. I'm assuming that fixing ARM code is higher
priority than adding Thumb support?

-- 
Tixy
