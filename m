From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 1 Oct 2014 13:37:30 +0300
Subject: [PATCH 0/4] ARM: dts: keystone: fixes
Message-ID: <1412159854-21143-1-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Snatosh,

This small set of DTS fixes for Keystone 2 SoCs, which
I've done while testing kernel boot on linux-next (3.18).

Grygorii Strashko (4):
  ARM: dts: keystone: fix io range for usb_phy
  ARM: dts: keystone-k2e: update usb1 node for dma properties
  ARM: dts: keystone-k2e: fix mdio io start address
  ARM: dts: keystone-k2l: fix mdio io start address

 arch/arm/boot/dts/k2e.dtsi      | 6 ++++++
 arch/arm/boot/dts/k2l.dtsi      | 4 ++++
 arch/arm/boot/dts/keystone.dtsi | 2 +-
 3 files changed, 11 insertions(+), 1 deletion(-)

-- 
1.9.1
