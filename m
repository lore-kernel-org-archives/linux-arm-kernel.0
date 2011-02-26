From: banajit.g@samsung.com (Banajit Goswami)
Date: Sat, 26 Feb 2011 13:29:00 +0900
Subject: [PATCH 0/6] ARM: SAMSUNG: Add support PWM backlight
Message-ID: <1298694546-16816-1-git-send-email-banajit.g@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support PWM backlight for S5P SoCs.

1. Move PWM timer code from plat-s3c24xx to plat-samsung for common useability
2. Add PWM backlight support for SMDK6410/6440/6450/C100 and SMDKV210

Note: The modification of GPIO F for S5P64X0 patch should be merged first as
there is a dependency for PWM on S5P64X0.

[PATCH 1/6] ARM: SAMSUNG: Move PWM device definition from plat-s3c24xx to plat-samsung
[PATCH 2/6] ARM: S3C64XX: Add PWM backlight support on SMDK6410
[PATCH 3/6] ARM: S5P64X0: Add PWM backlight support on SMDK6440
[PATCH 4/6] ARM: S5P64X0: Add PWM backlight support on SMDK6450
[PATCH 5/6] ARM: S5PC100: Add PWM backlight support on SMDKC100
[PATCH 6/6] ARM: S5PV210: Add PWM backlight support on SMDKV210
