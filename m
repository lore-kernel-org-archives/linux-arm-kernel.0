From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Fri, 15 Feb 2013 12:03:29 +0530
Subject: [PATCH V 3] USB: ehci:mv bus glue as separate static module
Message-ID: <1360910011-2666-1-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Separate the mv On-Chip host controller driver from ehci-hcd
host code into its own static driver module 

Manjunath Goudar (1):
  USB: EHCI: make ehci-mv as separate static driver

 drivers/usb/host/Kconfig    |    2 +-
 drivers/usb/host/Makefile   |    1 +
 drivers/usb/host/ehci-hcd.c |    6 +---
 drivers/usb/host/ehci-mv.c  |   78 +++++++++++++++++++------------------------
 4 files changed, 38 insertions(+), 49 deletions(-)

-- 
1.7.9.5
