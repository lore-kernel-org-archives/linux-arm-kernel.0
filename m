From: sbkim73@samsung.com (Sangbeom Kim)
Date: Fri,  4 Mar 2011 14:21:36 +0900
Subject: [PATCH V2 0/3] ARM: S5P: Add HRT support for s5p series 
Message-ID: <1299216099-7709-1-git-send-email-sbkim73@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Following  patches support high resolution timer for s5p series.
In this version, I had modified clk_get scheme and Added sched_clock_support 
and clockevents_calc_mult_shift function. 
For initialization functions,Added  __init MACRO.
Basically, I had reflected comments of Russell King, Linus Walleij,
and Kyungmin Park.
 
Changes since v1:
 - Add sched_clock support (Linus Walleij)
 - Add clockevents_calc_mult_shift
 - Modify clk_get scheme
 - Default clockevent is PWM timer3
 
The patch series contains:

[PATCH V2 1/3] ARM: S5P: Add s5p_timer support for HRT
[PATCH V2 2/3] ARM: S5P: Update machine initialization for HRT
[PATCH V2 3/3] ARM: S5P: Update defconfig for HRT support

For applying this patch, It is needed pwm timer patches.
http://article.gmane.org/gmane.linux.kernel.samsung-soc/4178

Thanks and regards,
S.B. Kim
