From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2011 08:51:29 +0100
Subject: [PATCH 0/5] ARM: kprobes: Fixes and additions for ARM
	instruction emulation (part 6)
In-Reply-To: <1303206740-10101-1-git-send-email-tixy@yxit.co.uk>
References: <1303206740-10101-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <20110428075129.GG17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2011 at 10:52:15AM +0100, Tixy wrote:
> (This is a sixth and final set of patches)
> 
> When kprobes are inserted into code an ARM instruction is replaced
> by a breakpoint. When this is hit, the original instruction must be
> emulated out-of-line. This patchset fixes some bugs in the instruction
> decoding and adds emulation for some newer ARMv7 instructions.
> 
> [PATCH 1/5] ARM: kprobes: Reject probing of undefined data processing instructions
> [PATCH 2/5] ARM: kprobes: Add emulation of MOVW and MOVT instructions
> [PATCH 3/5] ARM: kprobes: Add emulation of SBFX, UBFX, BFI and BFC instructions
> [PATCH 4/5] ARM: kprobes: Add emulation of hint instructions like NOP and WFI
> [PATCH 5/5] ARM: kprobes: Tidy-up kprobes-decode.c

I notice that Nicolas merged the 5th set rather than this set - and
Nicolas hasn't responded to these.  Please check with Nicolas whether
he's updated to the latest set.
