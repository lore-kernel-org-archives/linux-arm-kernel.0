From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 13 Jan 2018 19:49:30 +0100
Subject: [PATCH 1/3] ARM: dts: rockchip: drop veyron's nonstandard
 'backlight-boot-off'
In-Reply-To: <20180106004757.8239-1-briannorris@chromium.org>
References: <20180106004757.8239-1-briannorris@chromium.org>
Message-ID: <3929059.IgKPAvtPnp@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 5. Januar 2018, 16:47:55 CET schrieb Brian Norris:
> This was used out-of-tree as a hack for resolving issues where some
> systems expect the backlight to turn on automatically at boot, while
> others expect to manage the backlight status via a DRM/panel driver.
> Those issues have since been fixed upstream in pwm_bl.c without device
> tree hacks, and so this un-documented property should no longer be
> useful.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

applied (for 4.17 though)


Thanks
Heiko
