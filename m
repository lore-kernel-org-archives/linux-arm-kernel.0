From: andrew@lunn.ch (Andrew Lunn)
Date: Wed,  8 Mar 2017 03:50:11 +0100
Subject: [PATCH 0/2] ZII Devel C: Wire up switch interrupts
Message-ID: <1488941413-8112-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both switches have a GPIO line on the SoC for interrupts. Add this to
the device tree.

The PHYs embedded in the switches support generating interrupts. These
are channel through the switch interrupt line. Add this to the device
tree as well.

Andrew Lunn (2):
  ARM: dts: vf610-zii-dev: Wire up devel C switch interrupts
  ARM: dts: vf610-zii-dev-c: Wire up PHY interrupts

 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts | 12 -----
 arch/arm/boot/dts/vf610-zii-dev-rev-c.dts | 77 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/vf610-zii-dev.dtsi      | 12 +++++
 3 files changed, 89 insertions(+), 12 deletions(-)

-- 
2.11.0
