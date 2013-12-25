From: kuninori.morimoto.gx@gmail.com (Kuninori Morimoto)
Date: Tue, 24 Dec 2013 16:51:23 -0800 (PST)
Subject: [PATCH 2/6] ARM: shmobile: r7s72100: Add RSPI clocks
In-Reply-To: <1387886210-3634-3-git-send-email-geert+renesas@linux-m68k.org>
References: <1387886210-3634-1-git-send-email-geert+renesas@linux-m68k.org>
 <1387886210-3634-3-git-send-email-geert+renesas@linux-m68k.org>
Message-ID: <87ioudhhx9.wl%kuninori.morimoto.gx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Geert

>  	/* MSTP clocks */
> +	CLKDEV_DEV_ID("rspi0", &mstp_clks[MSTP107]),
> +	CLKDEV_DEV_ID("rspi1", &mstp_clks[MSTP106]),
> +	CLKDEV_DEV_ID("rspi2", &mstp_clks[MSTP105]),
> +	CLKDEV_DEV_ID("rspi3", &mstp_clks[MSTP104]),
> +	CLKDEV_DEV_ID("rspi4", &mstp_clks[MSTP103]),

I think "rspi.x" is correct name ?

Best regards
---
Kuninori Morimoto
