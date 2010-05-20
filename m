From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 20 May 2010 19:28:28 +0900
Subject: [PATCH 0/3] [WATCHDOG] s3c2410_wdt - Support for Samsung SoCs and Bug
	fix on
Message-ID: <1274351311-6879-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patches add Watchdog support for Samsung SoCs.

- Add HAVE_S3C2410_WATCHDOG to control inclusion of watchdog driver
- Fix on handling of the request_mem_region fail

[PATCH v2 1/3] [WATCHDOG] s3c2410_wdt - Add extra option to include watchdog for Samsung SoCs
[PATCH v2 2/3] ARM: SAMSUNG: Move WDT device definitions in plat-samsung
[PATCH v2 3/3] [WATCHDOG] s3c2410_wdt - Fix on handling of the request_mem_region fail
