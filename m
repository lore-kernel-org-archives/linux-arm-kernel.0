From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 Mar 2012 10:19:32 -0800
Subject: [PATCH v3 1/2] ARM: OMAP: move generic EMAC init to separate file
In-Reply-To: <1330593544-25411-1-git-send-email-grinberg@compulab.co.il>
References: <1324423590-32489-1-git-send-email-yanok@emcraft.com>
 <1330593544-25411-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <20120305181932.GC12083@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Igor Grinberg <grinberg@compulab.co.il> [120301 00:47]:
> From: Ilya Yanok <yanok@emcraft.com>
> 
> AM35xx SoCs include DaVinci EMAC IP. Initialization code in
> board-am3517evm.c is pretty board independent and will work for any
> AM35xx based board so move this code to it's own file to be reused by
> other boards.
> 
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> ---
> v3:	- use DEFINE_RES_* macros
> 	- check error of platform_device_register()
> 	- introduce a default MDIO bus frequency define
> 
> Tony, this patch has been floating for about two months:
> http://www.spinics.net/lists/linux-omap/msg62160.html
> can it be applied for 3.4?

Yes sorry for the delays, applying this and the related
cm-t3517 patch to board branch.

Regards,

Tony
