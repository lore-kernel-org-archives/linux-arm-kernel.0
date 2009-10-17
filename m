From: daniel@caiaq.de (Daniel Mack)
Date: Sat, 17 Oct 2009 15:12:56 +0200
Subject: Patches for SPI support on Lilly1131 modules
Message-ID: <1255785180-18501-1-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here come four patches to support SPI on Lilly1131 modules in general and
the mc13783 in particular.

They apply to -rc5.

Daniel

[PATCH 1/4] ARM: MX3: remove I2C defintions from mx31lilly.c
[PATCH 2/4] ARM: MX3: add SPI functions for lilly1131-db
[PATCH 3/4] ARM: MX3: add support for mc13783 on lilly-db
[PATCH 4/4] ARM: MX3: add MX3X_UART1_BASE_ADDR for uncompression on lilly1131
