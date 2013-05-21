From: libo.chen@huawei.com (Libo Chen)
Date: Tue, 21 May 2013 10:42:00 +0800
Subject: [PATCH 00/19] driver:usb&net: add missing platform_driver owner
Message-ID: <1369104120-35552-1-git-send-email-libo.chen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I find a lot of mistakes using struct platform_driver without owner.
So I pick up some of them including usb and net modules

Libo Chen (19):
  drivers/usb/musb: add missing platform_driver owner
  drivers/usb/host: add missing platform_driver owner
  drivers/usb/chipidea: add missing platform_driver owner
  drivers/usb/dwc3: add missing platform_driver owner
  drivers/ust/renesas_usbhs: add missing platform_driver owner
  drivers/usb/phy: add missing platform_driver owner
  drivers/usb/gadget: add missing platform_driver owner
  drivers/net/ethernet/amd: add missing platform_driver owner
  drivers/net/ethernet: add missing platform_driver owner
  drivers/net/ethernet/freescale: add missing platform_driver owner
  drivers/net/ethernet/natsemi: add missing platform_driver owner
  drivers/net/ethernet/xscale: add missing platform_driver owner
  drivers/net/ethernet/calxeda: add missing platform_driver owner
  drivers/net/wireless/brcm80211/brcmfmac: add missing platform_driver
    owner
  drivers/net/irda: add missing platform_driver owner
  drivers/net/wan: add missing platform_driver owner
  drivers/net/ethernet/nxp: add missing platform_driver owner
  drivers/net/ethernet/marvell: add missing platform_driver owne
  drivers/net/ethernet/renesas: add missing platform_driver owner

 drivers/net/ethernet/amd/am79c961a.c                   | 1 +
 drivers/net/ethernet/calxeda/xgmac.c                   | 1 +
 drivers/net/ethernet/dnet.c                            | 3 ++-
 drivers/net/ethernet/freescale/xgmac_mdio.c            | 1 +
 drivers/net/ethernet/korina.c                          | 1 +
 drivers/net/ethernet/marvell/mvneta.c                  | 1 +
 drivers/net/ethernet/natsemi/xtsonic.c                 | 1 +
 drivers/net/ethernet/nxp/lpc_eth.c                     | 1 +
 drivers/net/ethernet/renesas/sh_eth.c                  | 1 +
 drivers/net/ethernet/xscale/ixp4xx_eth.c               | 1 +
 drivers/net/irda/bfin_sir.c                            | 1 +
 drivers/net/irda/sh_irda.c                             | 1 +
 drivers/net/irda/sh_sir.c                              | 1 +
 drivers/net/irda/smsc-ircc2.c                          | 1 +
 drivers/net/wan/ixp4xx_hss.c                           | 1 +
 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh_sdmmc.c | 3 ++-
 drivers/usb/chipidea/ci13xxx_msm.c                     | 2 +-
 drivers/usb/chipidea/core.c                            | 1 +
 drivers/usb/dwc3/core.c                                | 1 +
 drivers/usb/dwc3/dwc3-exynos.c                         | 1 +
 drivers/usb/dwc3/dwc3-omap.c                           | 1 +
 drivers/usb/gadget/r8a66597-udc.c                      | 1 +
 drivers/usb/host/ehci-atmel.c                          | 1 +
 drivers/usb/host/ehci-msm.c                            | 1 +
 drivers/usb/host/ehci-mv.c                             | 1 +
 drivers/usb/host/ehci-mxc.c                            | 1 +
 drivers/usb/host/ehci-omap.c                           | 1 +
 drivers/usb/host/ehci-spear.c                          | 1 +
 drivers/usb/host/isp1760-if.c                          | 1 +
 drivers/usb/host/oxu210hp-hcd.c                        | 1 +
 drivers/usb/host/xhci-plat.c                           | 1 +
 drivers/usb/musb/am35x.c                               | 1 +
 drivers/usb/musb/blackfin.c                            | 1 +
 drivers/usb/musb/da8xx.c                               | 1 +
 drivers/usb/musb/davinci.c                             | 1 +
 drivers/usb/musb/omap2430.c                            | 1 +
 drivers/usb/musb/tusb6010.c                            | 1 +
 drivers/usb/musb/ux500.c                               | 1 +
 drivers/usb/phy/phy-rcar-usb.c                         | 1 +
 drivers/usb/renesas_usbhs/common.c                     | 1 +
 40 files changed, 42 insertions(+), 3 deletions(-)

-- 
1.8.1.2
