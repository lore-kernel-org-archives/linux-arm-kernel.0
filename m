From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Wed, 13 Feb 2013 15:08:04 +0530
Subject: [PATCH V3] USB: ehci:mv bus glue as separate module
Message-ID: <1360748285-31710-1-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Separate the mv On-Chip host controller driver from ehci-hcd
host code into its own static driver module

Manjunath Goudar (1):
  USB: EHCI: make ehci-mv a separate driver

 drivers/usb/host/Kconfig    |    2 +-
 drivers/usb/host/Makefile   |    1 +
 drivers/usb/host/ehci-hcd.c |    6 +---
 drivers/usb/host/ehci-mv.c  |   80 ++++++++++++++++++++-----------------------
 4 files changed, 40 insertions(+), 49 deletions(-)

-- 
1.7.9.5
