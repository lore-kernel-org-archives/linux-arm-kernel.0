From: ks.giri@samsung.com (Girish K S)
Date: Mon, 17 Mar 2014 17:33:57 +0530
Subject: [PATCH 0/2] Support for samsung mailbox controller
Message-ID: <1395057839-23871-1-git-send-email-ks.giri@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is based on the mailbox framework prepared by jassi
and others.  

Girish K S (2):
  mailbox: samsung: added support for samsung mailbox
  arm64: dts: exynos: added mailbox node

 .../bindings/mailbox/samsung-mailbox.txt           |   24 ++
 arch/arm64/boot/dts/samsung-gh7.dtsi               |   66 ++++
 arch/arm64/boot/dts/samsung-ssdk-gh7.dts           |    3 +
 drivers/mailbox/Kconfig                            |    8 +
 drivers/mailbox/Makefile                           |    2 +
 drivers/mailbox/mailbox-samsung.c                  |  354 ++++++++++++++++++++
 include/linux/mailbox-samsung.h                    |  112 +++++++
 7 files changed, 569 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/samsung-mailbox.txt
 create mode 100644 drivers/mailbox/mailbox-samsung.c
 create mode 100644 include/linux/mailbox-samsung.h

-- 
1.7.10.4
