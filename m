From: manjunath.goudar@linaro.org (manjunath.goudar at linaro.org)
Date: Mon, 11 Feb 2013 18:03:27 +0530
Subject: [PATCH V2] usb: ehci: more bus glues as separate modules
In-Reply-To: <y>
References: <y>
Message-ID: <5118e529.4439440a.3347.ffffdc7d@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Manjunath Goudar <manjunath.goudar@linaro.org>

Separate the SOC On-Chip host controller driver from ehci-hcd
host code into its own driver module

Manjunath Goudar (1):
  USB: EHCI: make ehci-s5p a separate driver

 drivers/usb/host/Kconfig    |    2 +-
 drivers/usb/host/Makefile   |    1 +
 drivers/usb/host/ehci-hcd.c |    6 +---
 drivers/usb/host/ehci-s5p.c |   69 ++++++++++++++++++++++++-------------------
 4 files changed, 41 insertions(+), 37 deletions(-)

-- 
1.7.9.5
