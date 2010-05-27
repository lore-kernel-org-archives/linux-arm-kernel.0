From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 27 May 2010 17:22:00 +0900
Subject: [PATCH] Add Compact Flash driver for Samsung SoCs
Message-ID: <1274948524-2970-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patches add PATA driver for Samsung SoCs. And this enables
support for Compact Flash interfacing with Samsung SoCs.

[PATCH 1/4] ARM: S3C64XX: Add support for Compact Flash driver on SMDK6410
[PATCH 2/4] ARM: S5PV210: Add support for Compact Flash driver on SMDKV210/SMDKC110
[PATCH 3/4] ARM: S5PC100: Add support for Compact Flash driver on SMDKC100
[PATCH 4/4] pata_samsung: Add Samsung PATA controller driver
