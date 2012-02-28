From: javier.martin@vista-silicon.com (Javier Martin)
Date: Tue, 28 Feb 2012 17:31:47 +0100
Subject: [PATCH 0/4] i.MX27: visstrim_m10: Add several peripherals.
Message-ID: <1330446711-6970-1-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've splitted video related patch into three to attend Uwe's requirements
and have added RTC support too.

[PATCH v2 1/4] i.MX27: visstrim_m10: Sort IMX_HAVE_PLATFORM_MXC_MMC properly.
[PATCH v2 2/4] i.MX27: visstrim_m10: Register I2C devices after I2C busses have been added.
[PATCH v2 3/4] i.MX27: visstrim_m10: Add m41t00 RTC support.
[PATCH v2 4/4] i.MX27: visstrim_m10: Add video support.
