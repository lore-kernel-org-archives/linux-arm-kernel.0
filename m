From: embed3d@gmail.com (Philipp Rossak)
Date: Fri,  9 Feb 2018 18:52:33 +0100
Subject: [PATCH 0/3] Fix broken bananapi m2 devicetree/regulators
Message-ID: <20180209175236.21215-1-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchseries fixes the bananapi m1 devicetree, to be able to boot again.
The first two patches update/improve the devicetree and the last patch adds
all missing regulators.

Regards,
Philipp

Philipp Rossak (3):
  arm: dts: sun6i: a31s: bpi-m2: update mmc supply nodes
  arm: dts: sun6i: a31s: bpi-m2: improve pmic properties
  arm: dts: sun6i: a31s: fix: bpi-m2: add missing regulators

 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts | 70 +++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 3 deletions(-)

-- 
2.11.0
