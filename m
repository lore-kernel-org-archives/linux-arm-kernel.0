From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue,  7 Sep 2010 14:29:36 +0900
Subject: [PATCH 0/5] rtc: rtc-s3c: Fix RTC bugs for RTC-S3C
Message-ID: <1283837381-9575-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes on bugs of rtc-s3c.
However, each patch is independent.

This includes the following patches.

[PATCH 1/5] rtc: rtc-s3c: Fix access unit from byte to word on RTCCON
[PATCH 2/5] rtc: rtc-s3c: Fix setting missing field of getalarm
[PATCH 3/5] rtc: rtc-s3c: Fix on support RTC Alarm
[PATCH 4/5] rtc: rtc-s3c: Fix on RTC initialization method
[PATCH 5/5] rtc: rtc-s3c: Fix debug message format on RTC
