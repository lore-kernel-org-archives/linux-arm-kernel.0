From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 22 May 2018 11:21:06 +0530
Subject: [PATCH V2] ARM: davinci_all_defconfig: set CONFIG_BACKLIGHT_PWM=m
In-Reply-To: <20180518180953.9860-1-aford173@gmail.com>
References: <20180518180953.9860-1-aford173@gmail.com>
Message-ID: <58cf9dd1-2bb6-01f5-a5ed-f7006e3c2ba4@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 May 2018 11:39 PM, Adam Ford wrote:
> The da850-evm came with an LCD with a backlight tied to a pwm. This
> enables CONFIG_BACKLIGHT_PWM as a module so the PWM backlight can be
> used to maintain brightness control of the backlight.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied for v4.19.

Thanks,
Sekhar
