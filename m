From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 16 Nov 2010 09:02:51 +0900
Subject: [PATCH 0/3] rtc: rtc-s3c: Fix and Update s3c_rtc_setaie()
Message-ID: <1289865774-31073-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch includes fixing s3c_rtc_setaie() function for Samsung SoCs.

[PATCH 1/3] rtc: rtc-s3c: Fix return type and argument of s3c_rtc_setaie
[PATCH 2/3] rtc: rtc-s3c: Add spin_lock_irq in s3c_rtc_setaie
[PATCH 3/3] rtc: rtc-s3c: Change set alarm interrupt method in s3c_rtc_setaie
