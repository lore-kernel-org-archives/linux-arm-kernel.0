From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Fri, 25 Apr 2014 16:48:01 +0530
Subject: [PATCH 0/2] usb: ehci/ohci-exynos: Move to generic phy framework
Message-ID: <1398424683-20168-1-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added required support for getting phy-provider from generic phy framework

Based and tested on 'usb-next' branch of Greg's usb tree, with relevant
device tree patches (which i will sending soon).

Patch:
usb: ehci-exynos: Change to use phy provided by the generic phy framework
is the patch from Kamil's usb phy patch-series:
[PATCH v6 8/8] usb: ehci-exynos: Change to use phy provided by the generic phy framework
This is reworked for addressing review comments received in mailing list.

Patch:
usb: ohci-exynos: Add facility to use phy provided by the generic phy framework
is also reworked for addressing review comments.

Corresponding changelog for patches mentioned in each patch.

Kamil Debski (1):
  usb: ehci-exynos: Change to use phy provided by the generic phy
    framework

Vivek Gautam (1):
  usb: ohci-exynos: Add facility to use phy provided by the generic phy
    framework

 .../devicetree/bindings/usb/exynos-usb.txt         |   37 ++++++
 drivers/usb/host/ehci-exynos.c                     |  123 ++++++++++++++++++--
 drivers/usb/host/ohci-exynos.c                     |  123 ++++++++++++++++++--
 3 files changed, 263 insertions(+), 20 deletions(-)

-- 
1.7.10.4
