From: embed3d@gmail.com (Philipp Rossak)
Date: Wed, 14 Feb 2018 15:10:23 +0100
Subject: [PATCH v2 0/2] Fix broken bananapi m2 devicetree/regulators
Message-ID: <20180214141025.22171-1-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchseries fixes the bananapi m1 devicetree, to be able to boot again.
The first two patches update/improve the devicetree and the last patch adds
all missing regulators.

Regards,
Philipp

Changes since v1:
	* squashed commit 1 and 3
	* fix wrong mmc regulator

Philipp Rossak (2):
  arm: dts: sun6i: a31s: bpi-m2: improve pmic properties
  arm: dts: sun6i: a31s: fix: bpi-m2: add missing regulators

 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts | 63 ++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 3 deletions(-)

-- 
2.11.0
