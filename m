From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 20 May 2010 16:21:27 +0900
Subject: [PATCH 0/0] Add Watchdog support for Samsung SMDK6410,
	S5P6440 and S5Pv210
Message-ID: <1274340092-10706-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patches add Watchdog support for SMDK6410, S5P6440 and S5PV210.

- Add HAVE_S3C2410_WATCHDOG for selecting watchgog driver compile in each machine
- Add S3C_DEV_WDT for watchdog device definitions
- Fix freeing memory part when memory region could not be allocated s3c2410_wdt
- Add machine dependent part for watchdog support

[PATCH 1/5] ARM: SAMSUNG: Move WDT device definitions in plat-samsung
[PATCH 2/5] [WATCHDOG] s3c2410_wdt - Avoid freeing memory, if memory region could not be allocated
[PATCH 3/5] ARM: SMDK6410: Add Watchdog support for SMDK6410
[PATCH 4/5] ARM: S5P6440: Add Watchdog support for S5P6440
[PATCH 5/5] ARM: S5PV210: Add Watchdog support for S5PV210
