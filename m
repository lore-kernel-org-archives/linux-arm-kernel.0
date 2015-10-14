From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 14 Oct 2015 12:34:00 +0200
Subject: [PATCH 0/4] ARM: berlin: improve multi_v7_defconfig support
Message-ID: <1444818844-2865-1-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Some drivers used on a Marvell Berlin kernel were missing from
multi_v7_defconfig. This series add them.

Antoine

Antoine Tenart (4):
  ARM: multi_v7_defconfig: enable Berlin SATA PHY
  ARM: multi_v7_defconfig: enable Berlin USB PHY
  ARM: multi_v7_defconfig: enable pxa168 Ethernet
  ARM: multi_v7_defconfig: enable the Berlin ADC

 arch/arm/configs/multi_v7_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.6.1
