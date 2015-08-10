From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 10 Aug 2015 16:23:08 +0200
Subject: [PATCH 0/4] USB: host: ohci-at91: cleanups
Message-ID: <1439216592-11381-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here are a few cleanups for ohci-at91. This is the fallout of AT91 now being DT
only.

Alexandre Belloni (4):
  USB: host: ohci-at91: move at91_usbh_data definition in c file
  USB: host: ohci-at91: depend on OF
  USB: host: ohci-at91: merge ohci_at91_of_init in
    ohci_hcd_at91_drv_probe
  USB: host: ohci-at91: merge loops in ohci_hcd_at91_drv_probe

 drivers/usb/host/Kconfig            |   8 +-
 drivers/usb/host/ohci-at91.c        | 179 ++++++++++++++++--------------------
 include/linux/platform_data/atmel.h |  12 ---
 3 files changed, 85 insertions(+), 114 deletions(-)

-- 
2.1.4
