From: manjunath.goudar@linaro.org (manjunath.goudar at linaro.org)
Date: Wed, 13 Feb 2013 12:40:43 +0530
Subject: [PATCH V2] USB: ehci:Marvell bus glue as separate module
Message-ID: <511b3c81.024e420a.2a08.ffffc36c@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Manjunath Goudar <manjunath.goudar@linaro.org>

Separate the Marvell On-Chip host controller driver from ehci-hcd
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
