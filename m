From: manjunath.goudar@linaro.org (manjunath.goudar at linaro.org)
Date: Tue, 12 Feb 2013 17:15:22 +0530
Subject: [PATCH V3]usb: ehci: more bus glues as separate modules
In-Reply-To: <y>
References: <y>
Message-ID: <511a2b5f.a34e420a.345b.75df@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Manjunath Goudar <manjunath.goudar@linaro.org>

Separate the Atmel On-Chip host controller driver from ehci-hcd
host code into its own static driver module
 

Manjunath Goudar (1):
  USB: EHCI: make ehci-atmel a separate driver

 drivers/usb/host/Kconfig      |    8 +++++
 drivers/usb/host/Makefile     |    1 +
 drivers/usb/host/ehci-atmel.c |   76 ++++++++++++++++++++++-------------------
 drivers/usb/host/ehci-hcd.c   |   10 ++----
 drivers/usb/host/ehci.h       |    2 +-
 5 files changed, 53 insertions(+), 44 deletions(-)

-- 
1.7.9.5
