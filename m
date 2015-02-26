From: sbranden@broadcom.com (Scott Branden)
Date: Thu, 26 Feb 2015 08:08:47 -0800
Subject: [PATCH v2 0/2] Add support for Broadcom keypad controller
In-Reply-To: <Scott Branden <sbranden@broadcom.com>
References: <Scott Branden <sbranden@broadcom.com>
Message-ID: <1424966930-28097-1-git-send-email-sbranden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patchsets contains the Broadcom keypad controller driver
and device tree binding documentation.

Changes from v1:
- updated dt documentation to remove to matrix-keymap.txt
- removed bcm_kp_remove as it is not necessary
- removed key-interrupt-trigger-type dt binding
- added bcm_kp_report_keys and call to process key registers

Scott Branden (2):
  Input: bcm-keypad: add device tree bindings
  Input: bcm-keypad: Add Broadcom keypad controller

 .../devicetree/bindings/input/brcm,bcm-keypad.txt  | 108 +++++
 drivers/input/keyboard/Kconfig                     |  10 +
 drivers/input/keyboard/Makefile                    |   1 +
 drivers/input/keyboard/bcm-keypad.c                | 464 +++++++++++++++++++++
 4 files changed, 583 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/brcm,bcm-keypad.txt
 create mode 100644 drivers/input/keyboard/bcm-keypad.c

-- 
2.3.0
