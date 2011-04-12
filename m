From: tixy@yxit.co.uk (Tixy)
Date: Tue, 12 Apr 2011 07:45:20 +0100
Subject: [PATCH 0/6] ARM: kprobes: Fixes for ARM instruction emulation (part 4)
Message-ID: <1302590726-3484-1-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(This is a fourth set of patches)

When kprobes are inserted into code an ARM instruction is replaced
by a breakpoint. When this is hit, the original instruction must be
emulated out-of-line. This patchset fixes even more bugs in the
instruction decoding and emulation.

[PATCH 1/6] ARM: kprobes: Reject probing of LDRB instructions which load PC
[PATCH 2/6] ARM: kprobes: Add emulation of RBIT instruction
[PATCH 3/6] ARM: kprobes: Reject probing of undefined media instructions
[PATCH 4/6] ARM: kprobes: Fix emulation of SXTB16, SXTB, SXTH, UXTB16, UXTB and UXTH instructions
[PATCH 5/6] ARM: kprobes: Fix emulation of SMUAD, SMUSD and SMMUL instructions
[PATCH 6/6] ARM: kprobes: Fix emulation of USAD8 instructions
