From: sbkim73@samsung.com (Sangbeom Kim)
Date: Mon,  7 Mar 2011 09:09:11 +0900
Subject: [PATCH V3 0/3] ARM: S5P: Add HRT support for s5p series
Message-ID: <1299456554-15280-1-git-send-email-sbkim73@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v2:
 - Add S5P_HRT configuration for s5p_timer
 
Changes since v1:
 - Add sched_clock support (Linus Walleij)
 - Add clockevents_calc_mult_shift
 - Modify clk_get scheme
 - Default clockevent is PWM timer3
 
The patch series contains:

[PATCH V3 1/3] This patch adds support HR-Timer(High Resolution Timer)
[PATCH V3 2/3] This patch modify s5pv210_defconfig and s5p64x0_defconfig
[PATCH V3 3/3] This patch update mach-s5p64x0 and mach-s5pv210
