From: sbkim73@samsung.com (Sangbeom Kim)
Date: Sat, 26 Feb 2011 11:45:54 +0900
Subject: [PATCH 0/3] ARM: S5P: Add high resolution timer support 
Message-ID: <1298688357-20775-1-git-send-email-sbkim73@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set adds support for HRT(High Resolution Timer).
In Samsung SoCs, there is many HRT timer sources.
PWM Timer, System Timer, MCT, RTC can be used for that.
In this patches, Only support PWM Timer.
But All kind of pwm timer can be used for clock source.
This patch is tested on SMDKC110, SMDK6450.
APM is only tested on SMDKC110.
Next version will support System Timer, RTC, MCT.

[PATCH 1/3] ARM: S5P: Add s5p_timer support for HRT
[PATCH 2/3] ARM: S5P: Update machine initialization for HRT
[PATCH 3/3] ARM: S5P: Update defconfig for HRT support
