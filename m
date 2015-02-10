From: sbranden@broadcom.com (Scott Branden)
Date: Mon, 9 Feb 2015 16:07:39 -0800
Subject: [PATCH 0/2] Add support for Broadcom keypad controller
In-Reply-To: <Scott Branden <sbranden@broadcom.com>
References: <Scott Branden <sbranden@broadcom.com>
Message-ID: <1423526861-29579-1-git-send-email-sbranden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patchsets contains the Broadcom keypad controller driver
and device tree binding documentation.

Scott Branden (2):
  Input: bcm-keypad: add device tree bindings
  Input: bcm-keypad: Add Broadcom keypad controller

 .../devicetree/bindings/input/brcm,bcm-keypad.txt  | 118 +++++
 drivers/input/keyboard/Kconfig                     |  10 +
 drivers/input/keyboard/Makefile                    |   1 +
 drivers/input/keyboard/bcm-keypad.c                | 489 +++++++++++++++++++++
 4 files changed, 618 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/brcm,bcm-keypad.txt
 create mode 100644 drivers/input/keyboard/bcm-keypad.c

-- 
2.2.2
