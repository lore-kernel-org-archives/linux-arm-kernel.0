From: jekhor@gmail.com (Yauhen Kharuzhy)
Date: Tue, 22 Jun 2010 16:54:16 +0300
Subject: Add support of SD/MMC card detection on SMDK2416 board
Message-ID: <1277214857-817-1-git-send-email-jekhor@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds card detection setup to SDHCI platform data on SMDK2416.
It was not tested because I don't have access to SMDK2416 board anymore,
but I tested similar patch on another board.


Note: it depends on patches:

ARM: S3C24XX: Fix gpiolib support for ports K..M
ARM: S3C2416: Add clock definition for HSMMC1
ARM: S3C2416: Add platform helpers for setup SDHCI
Samsung: sdhci-s3c: add support for new card detection methods
sdhci-s3c: add support for the non standard minimal clock value
sdhci-s3c: add support for new card detection methods
