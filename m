From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 18 Apr 2011 14:41:02 -0400 (EDT)
Subject: [PATCH 0/5] ARM: kprobes: Fixes for ARM instruction emulation
	(part 5)
In-Reply-To: <1303113238-23920-1-git-send-email-tixy@yxit.co.uk>
References: <1303113238-23920-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <alpine.LFD.2.00.1104181440350.24613@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 18 Apr 2011, Tixy wrote:

> (This is a fifth set of patches)
> 
> When kprobes are inserted into code an ARM instruction is replaced
> by a breakpoint. When this is hit, the original instruction must be
> emulated out-of-line. This patchset fixes still more bugs in the
> instruction decoding and emulation.
> 
> [PATCH 1/5] ARM: kprobes: Reject probing of all coprocessor instructions
> [PATCH 2/5] ARM: kprobes: Consolidate stub decoding functions
> [PATCH 3/5] ARM: kprobes: Reject probing of SETEND instructions
> [PATCH 4/5] ARM: kprobes: Fix emulation of PLD instructions
> [PATCH 5/5] ARM: kprobes: Remove redundant code in space_1111

Lookes fine, merged.

Thanks


Nicolas
