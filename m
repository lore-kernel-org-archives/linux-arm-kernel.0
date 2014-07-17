From: fkan@apm.com (Feng Kan)
Date: Thu, 17 Jul 2014 13:57:22 -0700
Subject: [PATCH 0/3] mailbox: Add APM X-Gene platform mailbox driver
Message-ID: <1405630645-15337-1-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is to add the APM X-Gene platform mailbox driver. The mailbox driver
is based off Jassi Brar's mailbox framework. This patch set is based off 
the following git.

https://github.com/sumananna/mailbox.git

Feng Kan (3):
  mailbox: add support for APM X-Gene platform mailbox driver
  Documentation: mailbox: Add APM X-Gene SlimPro mailbox dts
    documentation
  arm64: dts: mailbox device tree node for APM X-Gene platform.

 .../bindings/mailbox/xgene-slimpro-mailbox.txt     |  41 +++
 arch/arm64/boot/dts/apm-storm.dtsi                 |  14 +
 drivers/mailbox/Kconfig                            |  10 +
 drivers/mailbox/Makefile                           |   1 +
 drivers/mailbox/mailbox-xgene-slimpro.c            | 287 +++++++++++++++++++++
 5 files changed, 353 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/xgene-slimpro-mailbox.txt
 create mode 100644 drivers/mailbox/mailbox-xgene-slimpro.c

-- 
1.9.1
