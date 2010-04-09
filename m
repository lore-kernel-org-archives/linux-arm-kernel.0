From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 09 Apr 2010 08:57:41 +0200
Subject: [PATCH] Add support for Samsung SoC OneNAND controllers
Message-ID: <1270796266-8272-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add support for Samsung SoC OneNAND controllers found
on S3C64xx, S5PC100 and S5PC110 chips. A few extensions to OneNAND core
were required to make the driver working properly on all supported SoCs.

The required platform setup code has been posted to relevant mailing
list (ARM Kernel: "[PATCH] ARM: Samsung: Add platform support code for
OneNAND controller" thread).

This patch series includes:

[PATCH 1/5] drivers: mtd: onenand: add support for chips with 4KB page size
[PATCH 2/5] drivers: mtd: onenand: allocate verify buffer in the core
[PATCH 3/5] drivers: mtd: onenand: add new callback for bufferram read
[PATCH 4/5] drivers: mtd: onenand: add workaround for SYNC_WRITE mode
[PATCH 5/5] drivers: mtd: add Samsung SoC OneNAND driver
