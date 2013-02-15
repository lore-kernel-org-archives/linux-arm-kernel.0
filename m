From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 15 Feb 2013 22:48:35 +0900
Subject: [PATCH 0/2] shmobile: kzm9g: correct smsc regulator registration
Message-ID: <1360936117-21765-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correct registration of regulators for the SMSC device on the kzm9g
and update the defconfig accordingly.

Simon Horman (2):
  ARM: shmobile: kzm9g: correct smsc regulator registration
  ARM: mach-shmobile: kzm9g: do not enable REGULATOR_DUMMY in defconfig

 arch/arm/configs/kzm9g_defconfig     |    1 -
 arch/arm/mach-shmobile/board-kzm9g.c |    4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)
