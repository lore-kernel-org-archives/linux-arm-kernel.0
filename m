From: jonathan.richardson@broadcom.com (Jonathan Richardson)
Date: Mon, 24 Oct 2016 12:12:01 -0700
Subject: [PATCH v1 0/3] Add support for Broadcom OTP controller
Message-ID: <1477336324-10543-1-git-send-email-jonathan.richardson@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds support for Broadcom's OTP controller found on chips such
as Cygnus and Stingray. A node has been added to the Cygnus dts.


Jonathan Richardson (3):
  dt-bindings: Document Broadcom OTP controller driver
  nvmem: Add the Broadcom OTP controller driver
  ARM: dts: Add node for Broadcom OTP controller driver

 .../devicetree/bindings/nvmem/brcm,ocotp.txt       |  17 ++
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |   7 +
 drivers/nvmem/Kconfig                              |  12 +
 drivers/nvmem/Makefile                             |   2 +
 drivers/nvmem/bcm-ocotp.c                          | 335 +++++++++++++++++++++
 5 files changed, 373 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/brcm,ocotp.txt
 create mode 100644 drivers/nvmem/bcm-ocotp.c

-- 
1.9.1
