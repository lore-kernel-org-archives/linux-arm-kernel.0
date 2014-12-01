From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 01 Dec 2014 01:05:16 +0100
Subject: [PATCH] ARM: dts: rockchip: set FIFO size for SDMMC, SDIO and EMMC
In-Reply-To: <1417170254-13615-1-git-send-email-julien.chauveau@neo-technologies.fr>
References: <1417170254-13615-1-git-send-email-julien.chauveau@neo-technologies.fr>
Message-ID: <3674430.hGHycMC0Vo@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 28. November 2014, 11:24:14 schrieb Julien CHAUVEAU:
> The SDMMC, SDIO and EMMC controllers use an external FIFO whose size is
> 256x32bit. This patch set the corresponding fifo-depth properties for both
> RK3066 and RK3188.
> 
> Signed-off-by: Julien CHAUVEAU <julien.chauveau@neo-technologies.fr>

applied to my dts branch
