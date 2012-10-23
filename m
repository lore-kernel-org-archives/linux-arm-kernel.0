From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 23 Oct 2012 10:42:41 +0200
Subject: [PATCH] arm: mvebu: support for the PlatHome OpenBlocks AX3 board
In-Reply-To: <1350980365-6698-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1350980365-6698-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20121023084241.GV11837@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
> index 49d7915..cd2717b 100644
> --- a/arch/arm/mach-mvebu/armada-370-xp.c
> +++ b/arch/arm/mach-mvebu/armada-370-xp.c
> @@ -49,6 +49,7 @@ static void __init armada_370_xp_dt_init(void)
>  static const char * const armada_370_xp_dt_board_dt_compat[] = {
>  	"marvell,a370-db",
>  	"marvell,axp-db",
> +	"plathome,openblocks-ax3",
>  	NULL,
>  };

Hi Thomas

You will get less merge conflicts with new boards if you keep this
list sorted.

    Andrew
