From: qnguyen@apm.com (Quan Nguyen)
Date: Thu,  7 Jan 2016 17:27:05 +0700
Subject: [PATCH v3 0/3] Enable X-Gene standby GPIO as interrupt controller
Message-ID: <1452162428-26839-1-git-send-email-qnguyen@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

V3 Changes:
        - Picking up from version 2 of "Y Vo <yvo@apm.com>"
        - Get HW resource information from DT
        - Avoid keeping parent IRQ controller
V2 Changes:
        - Support X-Gene standby GPIO as an interrupt controller.

Quan Nguyen (3):
  gpio: xgene: Enable X-Gene standby GPIO as interrupt controller
  Documentation: gpio: Update description for X-Gene standby GPIO
    controller DTS binding
  arm64: dts: Update X-Gene standby GPIO controller DTS entries

 .../devicetree/bindings/gpio/gpio-xgene-sb.txt     |  49 +++-
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |   5 +-
 drivers/gpio/gpio-xgene-sb.c                       | 289 ++++++++++++++++++---
 3 files changed, 289 insertions(+), 54 deletions(-)

-- 
2.2.0
