From: code@mmayer.net (Markus Mayer)
Date: Mon,  5 Jun 2017 14:09:28 -0700
Subject: [PATCH 0/2] thermal: add brcmstb AVS TMON driver
Message-ID: <20170605210930.65432-1-code@mmayer.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Mayer <mmayer@broadcom.com>

This series adds the brcmstb AVS TMON driver.

The driver was originally written by Brian Norris. I ported it to Linux
4.12-rc1. The series also applies to linux-next as of 20170605.

Brian Norris (2):
  Documentation: devicetree: add binding for Broadcom STB AVS TMON
  thermal: add brcmstb AVS TMON driver

 .../devicetree/bindings/thermal/brcm,avs-tmon.txt  |  20 ++
 MAINTAINERS                                        |   8 +
 drivers/thermal/broadcom/Kconfig                   |   7 +
 drivers/thermal/broadcom/Makefile                  |   1 +
 drivers/thermal/broadcom/brcmstb_thermal.c         | 361 +++++++++++++++++++++
 5 files changed, 397 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt
 create mode 100644 drivers/thermal/broadcom/brcmstb_thermal.c

-- 
2.7.4
