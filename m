From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 23 Apr 2013 16:03:04 +0100
Subject: [PATCH 00/10] usb: musb: ux500: pathe the way for Device Tree
 enablement
Message-ID: <1366729394-11406-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In this patch-set we firstly ease the burden on data being passed from
platform data, then start to build up support to finally enable Device
Tree.

 Documentation/devicetree/bindings/usb/ux500-usb.txt |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dbx5x0.dtsi                       |   31 ++++++++++++++++++++++++++++++-
 arch/arm/mach-ux500/cpu-db8500.c                    |   17 ++---------------
 arch/arm/mach-ux500/usb.c                           |   25 ++++++-------------------
 drivers/usb/musb/ux500.c                            |   61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/usb/musb/ux500_dma.c                        |   59 +++++++++++++++++++++++++++++++++--------------------------
 include/linux/platform_data/usb-musb-ux500.h        |    5 +----
 7 files changed, 181 insertions(+), 66 deletions(-)
