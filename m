From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 4 Jun 2013 12:52:07 +0200
Subject: [PATCH v2 1/4] clocksource: dw_apb_timer_of: enable the use the
 clocksource as sched clock
In-Reply-To: <201306041137.03319.heiko@sntech.de>
References: <201306041136.09566.heiko@sntech.de>
 <201306041137.03319.heiko@sntech.de>
Message-ID: <201306041252.07877.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 4. Juni 2013, 11:37:02 schrieb Heiko St?bner:
> Currently the dw_apb_timer always expects a separate special timer to be
> availbable for the sched_clock. Some devices using dw_apb_timers do not
> have this sptimer but can use the clocksource as sched_clock instead.
> 
> Therefore enable the driver to distiguish between devices with and without
> sptimer based on the devicetree data and select the correct timer as
> sched_clock.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

in the original thread "arm: add basic support for Rockchip Cortex-A9 SoCs" 
this patch with the updated description now also got a


Acked-by: Linus Walleij <linus.walleij@linaro.org>
