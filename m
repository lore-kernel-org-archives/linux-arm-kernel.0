From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 18 May 2018 18:08:50 +0530
Subject: [PATCH] ARM: davinci_all_defconfig: set CONFIG_BACKLIGHT_PWM=m
In-Reply-To: <20180518004331.28120-1-aford173@gmail.com>
References: <20180518004331.28120-1-aford173@gmail.com>
Message-ID: <bf553095-7401-fb41-711f-8df9d30c9c11@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 May 2018 06:13 AM, Adam Ford wrote:
> The da850-evm came with an LCD with a backlight tied to a pwm. This
> enables CONFIG_BACKLIGHT_PWM as a module so the PWM backlight can be
> used to maintain brightness control of the backlight.
> 
> Note: make savedefconfig changed the order of one of the config options

Can you leave out that hunk instead? At some point I will do a
savedefconfig resync.

> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Thanks,
Sekhar
