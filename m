From: manjunath.goudar@linaro.org (manjunath.goudar at linaro.org)
Date: Wed, 13 Feb 2013 13:01:00 +0530
Subject: [PATCH V2] usb: ehci: ehci-vt8500 bus glue as separate module
In-Reply-To: <y>
References: <y>
Message-ID: <1360740661-14125-1-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Manjunath Goudar <manjunath.goudar@linaro.org>

Separate the vt8500 On-Chip host controller driver from ehci-hcd
host code into its own static driver module

Manjunath Goudar (1):
  USB: EHCI: make ehci-vt8500 a separate driver

 drivers/usb/host/Kconfig       |    8 +++++
 drivers/usb/host/Makefile      |    1 +
 drivers/usb/host/ehci-hcd.c    |    6 +---
 drivers/usb/host/ehci-vt8500.c |   73 ++++++++++++++++++----------------------
 4 files changed, 43 insertions(+), 45 deletions(-)

-- 
1.7.9.5
