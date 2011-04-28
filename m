From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 28 Apr 2011 12:49:18 -0400 (EDT)
Subject: [PATCH 0/5] ARM: kprobes: Fixes and additions for ARM instruction
	emulation (part 6)
In-Reply-To: <1303986831.2441.17.camel@computer2.home>
References: <1303206740-10101-1-git-send-email-tixy@yxit.co.uk>
	<20110428075129.GG17290@n2100.arm.linux.org.uk>
	<1303986831.2441.17.camel@computer2.home>
Message-ID: <alpine.LFD.2.00.1104281243290.24613@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 Apr 2011, Tixy wrote:

> On Thu, 2011-04-28 at 08:51 +0100, Russell King - ARM Linux wrote:
> > On Tue, Apr 19, 2011 at 10:52:15AM +0100, Tixy wrote:
> > > (This is a sixth and final set of patches)
> > > 
> > > When kprobes are inserted into code an ARM instruction is replaced
> > > by a breakpoint. When this is hit, the original instruction must be
> > > emulated out-of-line. This patchset fixes some bugs in the instruction
> > > decoding and adds emulation for some newer ARMv7 instructions.
> > > 
> > > [PATCH 1/5] ARM: kprobes: Reject probing of undefined data processing instructions
> > > [PATCH 2/5] ARM: kprobes: Add emulation of MOVW and MOVT instructions
> > > [PATCH 3/5] ARM: kprobes: Add emulation of SBFX, UBFX, BFI and BFC instructions
> > > [PATCH 4/5] ARM: kprobes: Add emulation of hint instructions like NOP and WFI
> > > [PATCH 5/5] ARM: kprobes: Tidy-up kprobes-decode.c
> > 
> > I notice that Nicolas merged the 5th set rather than this set - and
> > Nicolas hasn't responded to these.  Please check with Nicolas whether
> > he's updated to the latest set.
> 
> Nicolas, I see you have part 6 in your personal Linaro kprobes branch,
> but Russell seems to imply that this is missing from a merge you did
> elsewhere. (I'm unsure where this merge might be.)

All the kprobes patches I've reviewed are in the kprobes branch of 
git://git.linaro.org/people/nico/linux.  So far I have 31 patches in 
there.  If something is missing please let me know.

I merged the lot in the Linaro kernel tree as well, that's all.


Nicolas
