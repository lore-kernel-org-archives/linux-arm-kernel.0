From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 12 Mar 2011 08:08:30 +0900
Subject: [PATCH v4 0/3] ARM: S5P: Add HRT support for s5p series
In-Reply-To: <1299636813-4869-1-git-send-email-sbkim73@samsung.com>
References: <1299636813-4869-1-git-send-email-sbkim73@samsung.com>
Message-ID: <002201cbe041$3eca1c00$bc5e5400$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sangbeom Kim wrote:
> 
> The Following  patches support high resolution timer for s5p series.
> In this version, I had modified smdkv210 clockevent source.
> Because, PWM timer3 is used as  pwm backlight driver in the smdkv210.
> and In previous version(v3), I had made a mistake for making patches.
> 
> Changes since v3:
>  - Change smdkv210 clockevent source by PWM timer2
> 
> Changes since v2:
>  - Add S5P_HRT configuration for s5p_timer
> 
> Changes since v1:
>  - Add sched_clock support (Linus Walleij)
>  - Add clockevents_calc_mult_shift
>  - Modify clk_get scheme
>  - Default clockevent is PWM timer3
> 
> The patch series contains:
> 
> [PATCH v4 1/3] ARM: S5P: Add s5p_timer support for HRT
> [PATCH v4 2/3] ARM: S5P: Update machine initialization for HRT
> [PATCH v4 3/3] ARM: S5P: Update defconfig for HRT support

Looks ok to me, will apply with following.
- removing .shift which is not needed (Jamie's pointing out)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
