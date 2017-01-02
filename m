From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 02 Jan 2017 15:25:25 +0000
Subject: [PATCH 0/5] ARM: dts: armada388: rework clearfog's .dtsi references
References: <E1cO454-00083C-Tj@rmk-PC.armlinux.org.uk>
Message-ID: <E1cO4UH-0008SR-GW@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series, based upon the previous series adding Clearfog Base
support, reworks the clearfog .dtsi file to reference nodes by label
rather than by path.

Not everything is moved - just those which had labels at the time the
patches were created.

 arch/arm/boot/dts/armada-388-clearfog-base.dts     |  15 +
 arch/arm/boot/dts/armada-388-clearfog.dtsi         | 353 ++++++++++-----------
 .../arm/boot/dts/armada-38x-solidrun-microsom.dtsi | 113 ++++---
 3 files changed, 245 insertions(+), 236 deletions(-)
