From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 7 Apr 2011 20:54:02 -0400 (EDT)
Subject: [PATCH 0/5] ARM: kprobes: Fixes for ARM instruction emulation
	(part 2)
In-Reply-To: <1302179119-17573-1-git-send-email-tixy@yxit.co.uk>
References: <1302179119-17573-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <alpine.LFD.2.00.1104072051470.28032@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Apr 2011, Tixy wrote:

> (This is a second set of patches)
> 
> When kprobes are inserted into code an ARM instruction is replaced
> by a breakpoint. When this is hit, the original instruction must be
> emulated out-of-line. This patchset fixes some more bugs in the
> instruction decoding and emulation.
> 
> [PATCH 1/5] ARM: kprobes: Reject probing MRS instructions which read SPSR
> [PATCH 2/5] ARM: kprobes: Fix emulation of MRS instruction
> [PATCH 3/5] ARM: kprobes: Reject probing of instructions which write to PC unpredictably.
> [PATCH 4/5] ARM: kprobes: Fix error in comment
> [PATCH 5/5] ARM: kprobes: Reject probing of undefined multiply instructions

This looks good too and I've committed them to the same branch.  Thanks!


Nicolas
