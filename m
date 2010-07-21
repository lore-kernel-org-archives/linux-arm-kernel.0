From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 Jul 2010 17:57:43 +0900
Subject: [PATCH 0/3] Updates RTC driver for Samsung S3C64XX and newer SoCs
Message-ID: <1279702666-13021-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates RTC driver for Samsung S3C64XX and newer SoCs.

NOTE: depends on previous RTC patch for clock enabling.

[PATCH 1/3] ARM: SAMSUNG: Updates RTC register for support Alarm IRQ and Time Tick.
[PATCH 2/3] rtc: rtc-s3c: Updates driver for S3C64XX and newer SoCs
[PATCH 3/3] rtc: rtc-s3c: Add BCD register initialization codes
