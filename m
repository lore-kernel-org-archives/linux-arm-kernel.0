From: andrew@lunn.ch (Andrew Lunn)
Date: Wed,  2 Dec 2015 00:33:27 +0100
Subject: [PATCH 0/5] multi and mvebu v5 defconfig updates
Message-ID: <1449012812-9779-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset updates both multi_v5_defconfig and mvebu_v5_defconfig.
It adds support for Orion5x, now that it is multi-arch, and adds back
DSA and its drivers, which now depends on switchdev.

Andrew Lunn (5):
  ARM: config: Regenerate multi_v5_defconfig
  ARM: config: Reenable DSA in multi_v5_defconfig
  ARM: config: Add orion5x to multi_v5_defconfig
  ARM: mvebu: Reenable DSA in mvebu_v5_defconfig
  ARM: mvebu: update v5 defconfig for Orion5x machines

 arch/arm/configs/multi_v5_defconfig | 43 +++++++++++++++++++++++++++----------
 arch/arm/configs/mvebu_v5_defconfig | 31 +++++++++++++++++++++++++-
 2 files changed, 62 insertions(+), 12 deletions(-)

-- 
2.6.2
