From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Fri, 25 Apr 2014 17:01:23 +0530
Subject: [PATCH v7 0/2] dts: Add usb2phy to Exynos 5250
Message-ID: <1398425485-20574-1-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Next version of patch for Kamil's patch:
[PATCH v6 4/8] dts: Add usb2phy to Exynos 5250
https://lkml.org/lkml/2014/1/29/302

Based on 'for-next' branch of Kgene's linux-samsung tree.
Tested with driver side patches:
[PATCH 0/2] usb: ehci/ohci-exynos: Move to generic phy framework
https://www.mail-archive.com/linux-usb at vger.kernel.org/msg41246.html

Changes from v6:
 - Splitted the patch into two:
    adding syscon nodes to Exynos5250 and Exynos5420 in first;
    and phy entry change in the second.
 - Changed the name of phandle for usb2phy from 'usb2_phy_new'
   to 'usb2_phy_gen' indicating generic phy.
 - Using clock macros in dt entries.

Kamil Debski (1):
  ARM: dts: Add usb2phy to Exynos 5250

Vivek Gautam (1):
  ARM: dts: Add sysreg sytem controller node to exynos5250 and
    exynos5420

 arch/arm/boot/dts/exynos5250.dtsi |   31 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5420.dtsi |    5 +++++
 2 files changed, 36 insertions(+)

-- 
1.7.10.4
