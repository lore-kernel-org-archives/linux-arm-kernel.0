From: rajeshwari.s@samsung.com (Rajeshwari Shinde)
Date: Mon, 20 Jun 2011 17:27:26 +0530
Subject: [PATCH 0/3] ARM: Add SDMMC support for S5P64X0
Message-ID: <1308571049-4412-1-git-send-email-rajeshwari.s@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: rajeshwari.s <rajeshwari.s@samsung.com>

S5P64X0 supports 3 Channel MMC/SDHC/SDIO.

This patchset adds the setup files, gpio configs and enables the HSMMC device 
for S5P64X0.

 o To Kukjin Kim and Sangbeom Kim 
[PATCH 1/3] ARM: S5P64X0: Add HSMMC setup for host Controller
[PATCH 2/3] ARM: S5P64X0: Initialize default SDHCI devices and platform data
[PATCH 3/3] ARM: S5P64X0: Enable SDHCI support
---
