From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 8 Apr 2011 15:31:13 -0400 (EDT)
Subject: [PATCH 0/4] ARM: kprobes: Fixes for ARM instruction emulation
	(part 3)
In-Reply-To: <1302273176-6414-1-git-send-email-tixy@yxit.co.uk>
References: <1302273176-6414-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <alpine.LFD.2.00.1104081529590.28032@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 8 Apr 2011, Tixy wrote:

> (This is a third set of patches)
> 
> When kprobes are inserted into code an ARM instruction is replaced
> by a breakpoint. When this is hit, the original instruction must be
> emulated out-of-line. This patchset fixes yet more bugs in the
> instruction decoding and emulation.
> 
> [PATCH 1/4] ARM: kprobes: Reject probing of STREX and LDREX instructions
> [PATCH 2/4] ARM: kprobes: Fix emulation of LDRH, STRH, LDRSB and LDRSH instructions
> [PATCH 3/4] ARM: kprobes: Reject probing of LDR/STR instructions which update PC unpredictably
> [PATCH 4/4] ARM: kprobes: Fix emulation of LDRD and STRD instructions

Good catches!  Merged.


Nicolas
