From: manjunath.goudar@linaro.org (manjunath.goudar at linaro.org)
Date: Tue, 12 Feb 2013 16:31:59 +0530
Subject: [PATCH V3] USB:ehci: more bus glues as separate modules
In-Reply-To: <y>
References: <y>
Message-ID: <511a214d.294e420a.5385.ffffd393@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Manjunath Goudar <manjunath.goudar@linaro.org>

Separate the SPEAr On-Chip host controller driver from ehci-hcd
host code into its own static driver module and replacing spear to 
SPEAr in leaving functions/variables/config options.

Manjunath Goudar (1):
  USB: EHCI: make ehci-spear a separate driver

 drivers/usb/host/Kconfig      |    8 +++++
 drivers/usb/host/Makefile     |    2 +-
 drivers/usb/host/ehci-hcd.c   |    6 +---
 drivers/usb/host/ehci-spear.c |   77 +++++++++++++++++++++--------------------
 4 files changed, 50 insertions(+), 43 deletions(-)

-- 
1.7.9.5
