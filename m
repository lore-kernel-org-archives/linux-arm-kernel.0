From: fkan@apm.com (Feng Kan)
Date: Wed, 22 Apr 2015 15:18:41 -0700
Subject: [PATCH V2 0/4] APM X-Gene Mailbox driver
Message-ID: <1429741125-29156-1-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the mailbox driver for the APM X-Gene SoC

V2 change
	- Add ACPI support
	- use defines for reg offset

Feng Kan (4):
  mailbox: add support for APM X-Gene platform mailbox driver
  mailbox: xgene: add ACPI support for X-Gene mailbox driver
  Documentation: mailbox: Add APM X-Gene SLIMpro mailbox dts
    documentation
  arm64: dts: mailbox device tree node for APM X-Gene platform.

 .../bindings/mailbox/xgene-slimpro-mailbox.txt     |  34 +++
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |  14 ++
 drivers/mailbox/Kconfig                            |  10 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/mailbox-xgene-slimpro.c            | 271 +++++++++++++++++++++
 5 files changed, 331 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/xgene-slimpro-mailbox.txt
 create mode 100644 drivers/mailbox/mailbox-xgene-slimpro.c

-- 
1.9.1
