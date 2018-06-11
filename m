From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 11 Jun 2018 15:47:11 -0700
Subject: [PATCH 0/3] ARM: dts: IRQ_TYPE_NONE fixes for NSP and HR2
Message-ID: <20180611224714.7007-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch series fixes incorrect interrupt type specifiers for the
NSP and HR2 SoCs.

Florian Fainelli (3):
  ARM: dts: NSP: Fix i2c controller interrupt type
  ARM: dts: NSP: Fix PCIe controllers interrupt types
  ARM: dts: HR2: Fix interrupt types for i2c and PCIe

 arch/arm/boot/dts/bcm-hr2.dtsi | 24 ++++++++++++------------
 arch/arm/boot/dts/bcm-nsp.dtsi | 32 ++++++++++++++++----------------
 2 files changed, 28 insertions(+), 28 deletions(-)

-- 
2.14.1
