From: sergio.prado@e-labworks.com (Sergio Prado)
Date: Fri, 25 Nov 2016 12:47:27 -0200
Subject: [PATCH 0/2] usb: ohci: s3c2410: add device tree support
Message-ID: <1480085249-25014-1-git-send-email-sergio.prado@e-labworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for configuring Samsung's s3c2410 and
compatible USB OHCI controller via devicetree.

Tested on FriendlyARM mini2440, based on s3c2440 SoC.

Sergio Prado (2):
  dt-bindings: usb: add DT binding for s3c2410 USB OHCI controller
  usb: ohci: s3c2410: allow probing from device tree

 .../devicetree/bindings/usb/s3c2410-usb.txt        | 22 ++++++++++++++++++++++
 drivers/usb/host/ohci-s3c2410.c                    |  8 ++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/s3c2410-usb.txt

-- 
1.9.1
