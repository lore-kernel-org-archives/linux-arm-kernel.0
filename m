From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 28 Feb 2011 19:53:28 +0900
Subject: [PATCH 0/6] ARM: SAMSUNG: Add support PWM backlight
In-Reply-To: <1298694546-16816-1-git-send-email-banajit.g@samsung.com>
References: <1298694546-16816-1-git-send-email-banajit.g@samsung.com>
Message-ID: <003401cbd735$be0b20f0$3a2162d0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Banajit Goswami wrote:
> 
> This patch adds support PWM backlight for S5P SoCs.
> 
> 1. Move PWM timer code from plat-s3c24xx to plat-samsung for common
> useability
> 2. Add PWM backlight support for SMDK6410/6440/6450/C100 and SMDKV210
> 
> Note: The modification of GPIO F for S5P64X0 patch should be merged first
as
> there is a dependency for PWM on S5P64X0.
> 
> [PATCH 1/6] ARM: SAMSUNG: Move PWM device definition from plat-s3c24xx to
> plat-samsung
> [PATCH 2/6] ARM: S3C64XX: Add PWM backlight support on SMDK6410
> [PATCH 3/6] ARM: S5P64X0: Add PWM backlight support on SMDK6440
> [PATCH 4/6] ARM: S5P64X0: Add PWM backlight support on SMDK6450
> [PATCH 5/6] ARM: S5PC100: Add PWM backlight support on SMDKC100
> [PATCH 6/6] ARM: S5PV210: Add PWM backlight support on SMDKV210

Ok, looks ok to me except adding unrelated platform devices.
Could you please re-work?

And please make sure that it works fine on each board before re-submitting
:)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
