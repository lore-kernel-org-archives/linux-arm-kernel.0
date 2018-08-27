From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Mon, 27 Aug 2018 17:10:52 +0200
Subject: [PATCH] ARM: at91: pm: remove pm_bu initialization in
 at91_pm_backup_init()
In-Reply-To: <1533714460-6883-1-git-send-email-claudiu.beznea@microchip.com>
References: <1533714460-6883-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <20180827151052.GD23428@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2018 10:47:40+0300, Claudiu Beznea wrote:
> There is no need to initialize pm_bu since it is used only if backup
> mode is selected. In case backup mode initialization fails (which means
> pm_bu is invalid) the ULP0 mode will be selected.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  arch/arm/mach-at91/pm.c | 3 ---
>  1 file changed, 3 deletions(-)
> 

Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
