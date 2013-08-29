From: joelf@ti.com (Joel Fernandes)
Date: Thu, 29 Aug 2013 18:27:50 -0500
Subject: [PATCH 0/3] crypto: omap-des: Add driver for OMAP DES module
Message-ID: <1377818873-21174-1-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP4 and AM437x SoCs have a DES3DES module which is capable of performing DES
encrypt/decrypt and 3DES ede encrypt/decrypt operations. Following patch series
adds support for the same.

Tests have been performed with crypto/testmgr and all tests are successful.

Joel Fernandes (3):
  crypto: omap-des: Add omap-des driver for OMAP4/AM43xx
  crypto: omap-des: Add config and build options
  crypto: omap-des: Add triple DES (des3_ede) support to driver

 drivers/crypto/Kconfig    |   11 +
 drivers/crypto/Makefile   |    1 +
 drivers/crypto/omap-des.c | 1239 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1251 insertions(+)
 create mode 100644 drivers/crypto/omap-des.c

-- 
1.8.1.2
