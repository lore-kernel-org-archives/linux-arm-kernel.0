From: s-anna@ti.com (Suman Anna)
Date: Tue, 24 Jun 2014 00:24:24 -0500
Subject: [PATCH 0/3] Misc. DSPBridge build/boot fixes
Message-ID: <1403587467-59876-1-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The following are couple of miscellaneous patches for fixing build and
boot issues when I attempted to build TI DSP/Bridge while doing the
adaptation and validation of OMAP mailbox driver against the mailbox
framework. The DSP/Bridge driver is disabled by default, so these can
be treated as non-urgent fixes.

Suman Anna (3):
  staging: tidspbridge: fix an erroneous removal of parentheses
  ARM: OMAP3: PRM/CM: Add back macros used by TI DSP/Bridge driver
  ARM: OMAP2+: create dsp device only on OMAP3 SoCs

 arch/arm/mach-omap2/cm-regbits-34xx.h         |  3 +++
 arch/arm/mach-omap2/dsp.c                     | 10 ++++++++++
 arch/arm/mach-omap2/prm-regbits-34xx.h        |  6 ++++++
 drivers/staging/tidspbridge/core/tiomap3430.c |  6 ++++--
 4 files changed, 23 insertions(+), 2 deletions(-)

-- 
2.0.0
