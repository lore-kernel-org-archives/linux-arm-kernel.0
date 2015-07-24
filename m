From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 24 Jul 2015 10:42:05 +0200
Subject: [PATCH v6 0/3] Add MediaTek display PWM driver
In-Reply-To: <1437380237-28961-1-git-send-email-yh.huang@mediatek.com>
References: <1437380237-28961-1-git-send-email-yh.huang@mediatek.com>
Message-ID: <2181696.fQcvS98Cqx@ubix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 20, 2015 04:17:14 PM YH Huang wrote:
> This patch series add the use of display PWM driver, documentation
> and device tree for Mediatek SoCs. The driver is used to support
> the backlight of the panel. This is based on v4.2-rc1.
> 
> The clock definitions (CLK_MM_DISP_PWM*) are added by James Liao's patch:
> clk: mediatek: Add subsystem clocks of MT8173
> 
> Change in v6:
> 1. Enable clocks in the pwm_enable function
> 2. Remove suspend/resume code since pwm-backlight driver has done the same
> things 3. Revise some code to make it easier to read
> 

Can you please provide the whole change log for all versions the next time.
It's easier this way to understand the evolution of the series.

Thanks,
Matthias
