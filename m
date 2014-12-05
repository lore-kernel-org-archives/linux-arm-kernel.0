From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 05 Dec 2014 22:45:53 +0100
Subject: [PATCH] ARM: dts: rockchip: set dw_mmc max-freq 150Mhz
In-Reply-To: <1417661375-2872-1-git-send-email-addy.ke@rock-chips.com>
References: <1417661375-2872-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <2413230.2M6GRRu59M@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 4. Dezember 2014, 10:49:35 schrieb Addy Ke:
> All of mmc controllers include SDMMC, SDIO0, SDIO1, and EMMC on RK3288
> are limited to 150Mhz. It was mainly caused by two reasons:
> - RK3288's IO pad(except DDR IO pad) is generic, which can only support
>   the max of 150Mhz.
> - Mmc controller was designed at 150Mhz, and the pressure test by IC team
>   was based on this freequency point.
> 
> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>

applied to my wip dts branch for 3.20 (on github)


Thanks
Heiko
