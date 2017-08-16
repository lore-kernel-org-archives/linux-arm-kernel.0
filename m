From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Wed, 16 Aug 2017 16:54:06 -0500
Subject: [PATCH v2 0/2] ARM: dts: k2g: Add support for USB instances on 66AK2G
Message-ID: <20170816215408.13076-1-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for 66AK2G usb instances. However, the driver needs to be updated
to support PM_RUNTIME. This update has been validated to work on K2L and boot
tested on K2HK and K2E.

Version 2:
Clarify clock properties requirements in binding document

Franklin S Cooper Jr (2):
  usb: dwc3: keystone: Add PM_RUNTIME Support to DWC3 Keystone USB
    driver
  dt-bindings: usb: keystone-usb: Update bindings pm and clocks
    properties

 .../devicetree/bindings/usb/keystone-usb.txt       | 17 +++++++++++++++--
 drivers/usb/dwc3/dwc3-keystone.c                   | 22 ++++++++++------------
 2 files changed, 25 insertions(+), 14 deletions(-)

-- 
2.9.4.dirty
