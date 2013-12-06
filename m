From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  6 Dec 2013 10:41:17 +0900
Subject: [PATCH 0/2] ARM: shmobile: kzm9g,
 armadillo800eva: Enable SMSC_PHY in defconfig
Message-ID: <1386294079-16392-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

these two patches enable the SMSC_PHY driver for the armadillo800eva
and kzm9d boards allowing them to make use of that driver rather
than relying on the generic phy driver.

If these patches are well received I plan to make similar
changes for other shmobile boards.

These patches are based on renesas-devel-v3.13-rc2-20131205.

Simon Horman (2):
  ARM: shmobile: kzm9g: Enable SMSC_PHY in defconfig
  ARM: shmobile: armadillo800eva: Enable SMSC_PHY in defconfig

 arch/arm/configs/armadillo800eva_defconfig | 1 +
 arch/arm/configs/kzm9g_defconfig           | 1 +
 2 files changed, 2 insertions(+)

-- 
1.8.4
