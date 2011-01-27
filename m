From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 27 Jan 2011 12:40:09 +0100
Subject: some i.MX23/28 patches
Message-ID: <1296128413-20778-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following contains some i.MX23/28 cleanup patches.

Sascha

The following changes since commit 376e9c5848abef8c72c09bd89f2f7ee128caa104:

  ARM: mxs: add initial pm support (2011-01-26 08:30:49 +0100)

are available in the git repository at:
  none ..BRANCH.NOT.VERIFIED..

Sascha Hauer (4):
      ARM i.MX23/28: deobfuscate gpio initialization
      ARM i.MX23/28: do not use complicated macros if not necessary
      ARM i.MX23: remove reserved register defines
      ARM i.MX28: remove reserved register defines

 arch/arm/mach-mxs/gpio.c              |   45 +++++----
 arch/arm/mach-mxs/regs-clkctrl-mx23.h |  124 -----------------------
 arch/arm/mach-mxs/regs-clkctrl-mx28.h |  177 ---------------------------------
 3 files changed, 24 insertions(+), 322 deletions(-)
