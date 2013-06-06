From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu,  6 Jun 2013 11:21:22 +0200
Subject: [PATCH] Minor fix for jcooper/for-next
Message-ID: <1370510483-32419-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jason,

Following our discussion yesterday evening/night, I did a test run of
jcooper/for-next this morning. It works fine, but requires the
following fix, that you can probably stack in mvebu/dt.

Thanks!

Thomas

Thomas Petazzoni (1):
  arm: mvebu: ensure PCIe range is propagated in the .dts files

 arch/arm/boot/dts/armada-xp-db.dts               | 1 +
 arch/arm/boot/dts/armada-xp-gp.dts               | 5 +++--
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts | 5 +++--
 3 files changed, 7 insertions(+), 4 deletions(-)

-- 
1.8.1.2
