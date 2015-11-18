From: rjui@broadcom.com (Ray Jui)
Date: Wed, 18 Nov 2015 10:16:58 -0800
Subject: [PATCH] Enable PCIe PHY support in Cygnus
Message-ID: <1447870619-2828-1-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enales PCIe PHY in device tree for Broadcom Cygnus based platforms

This patch is developed based on v4.4-rc1 and available here:
https://github.com/Broadcom/cygnus-linux/tree/cygnus-pcie-phy-dt-v1

Ray Jui (1):
  ARM: dts: enable PCIe PHY support for Cygnus

 arch/arm/boot/dts/bcm-cygnus.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

-- 
1.9.1
