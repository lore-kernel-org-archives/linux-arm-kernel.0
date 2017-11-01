From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Wed,  1 Nov 2017 09:03:56 +0100
Subject: [PATCH 0/1] ARM: dts: sunxi: sun8i-h3-nanopi-m1-plus: fix build
 failure
Message-ID: <20171101080357.4241-1-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

The following patch fix the build failure due to "ARM: dts: sunxi: Restore EMAC changes (boards)".
A made a mistake when rebasing and a part of sun8i-h3-nanopi-m1-plus emac
was added without the needed regulator.

Regards

Corentin Labbe (1):
  ARM: dts: sunxi: sun8i-h3-nanopi-m1-plus: Add missing regulator

 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

-- 
2.13.6
