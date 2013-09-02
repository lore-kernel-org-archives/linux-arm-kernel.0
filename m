From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 2 Sep 2013 13:27:39 +0200
Subject: [PULL REQUEST] big-endian updates for ARM
In-Reply-To: <52247567.8060504@codethink.co.uk>
References: <52247567.8060504@codethink.co.uk>
Message-ID: <20130902132739.3e11db90@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ben Dooks,

On Mon, 02 Sep 2013 12:24:23 +0100, Ben Dooks wrote:

> Ben Dooks (19):
>        ARM: fix ARCH_IXP4xx usage of ARCH_SUPPORTS_BIG_ENDIAN
>        ARM: asm: Add ARM_BE8() assembly helper
>        ARM: fixup_pv_table bug when CPU_ENDIAN_BE8
>        ARM: set BE8 if LE in head code
>        ARM: pl01x debug code endian fix
>        ARM: twd: data endian fix
>        ARM: smp_scu: data endian fixes
>        highbank: enable big-endian
>        fix highbank

Seems like you forgot to rebase your branch to squash this commit in
the previous one.

>        mvebu: support running big-endian
>        vexpress: add big endian support
>        ARM: alignment: correctly decode instructions in BE8 mode.
>        ARM: traps: use <asm/opcodes.h> to get correct instruction order
>        ARM: module: correctly relocate instructions in BE8
>        ARM: set --be8 when linking modules
>        ARM: hardware: fix endian-ness in <hardware/coresight.h>
>        ARM: net: fix arm instruction endian-ness in bpf_jit_32.c
>        ARM: Correct BUG() assembly to ensure it is endian-agnostic
>        ARM: kdgb: use <asm/opcodes.h> for data to be assembled as intruction
> 
> Victor Kamensky (2):
>        ARM: atomic64: fix endian-ness in atomic.h
>        ARM: signal: sigreturn_codes should be endian neutral to work in BE8

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
