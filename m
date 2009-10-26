From: daniel@caiaq.de (Daniel Mack)
Date: Mon, 26 Oct 2009 11:55:54 +0100
Subject: MX3: SPI/MMC/I2C fixes for lilly-1131 modules
Message-ID: <1256554559-17828-1-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the EHCI/ULPI bits for MXC seem to take a little longer, I rebased the
patches I sent earlier to apply without the USB code.

The following five patches address the mx31lilly modules and add support
for SPI, proper fast slope pin config for MMC and a missing define in the
uncompression code.

Daniel

[PATCH 1/5] ARM: MX3: remove I2C defintions from mx31lilly.c
[PATCH 2/5] ARM: MX3: add SPI functions for lilly1131-db
[PATCH 3/5] ARM: MX3: add support for mc13783 on lilly-db
[PATCH 4/5] ARM: MX3: Add pad config for MMC pins on lilly-db
[PATCH 5/5] ARM: MX3: add MX3X_UART1_BASE_ADDR for uncompression on lilly1131
