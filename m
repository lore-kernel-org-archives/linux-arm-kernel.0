From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Mon, 27 Jun 2011 20:43:23 +0900
Subject: [PATCH 0/3] RTC-S3C Bugfixes
Message-ID: <1309175006-9218-1-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1. Bugfix: incorrect debug messages
2. Bugfix: alarm entires not being reset
3. Bugfix (More like update?): allow to open rtc-s3c multiple times.

MyungJoo Ham (3):
  rtc: rtc-s3c: Correct debug messages.
  rtc: rtc-s3c: Disable alarm entries that are not chosen.
  rtc: rtc-s3c: allow multiple open / allow no-ioctl-open'ed rtc to
    have irq.

 drivers/rtc/rtc-s3c.c |   77 +++++++++++++++++-------------------------------
 1 files changed, 27 insertions(+), 50 deletions(-)

-- 
1.7.4.1
