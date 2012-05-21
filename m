From: b32955@freescale.com (Huang Shijie)
Date: Mon, 21 May 2012 11:08:11 +0800
Subject: [PATCH 1/4] GPMI-NAND: Define ecc.strength
In-Reply-To: <201205210440.09310.marex@denx.de>
References: <1337562140-5739-1-git-send-email-marex@denx.de>
 <201205210336.41860.marex@denx.de>
 <20120521014121.GO5427@S2101-09.ap.freescale.net>
 <201205210440.09310.marex@denx.de>
Message-ID: <4FB9B19B.2080309@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?05?21? 10:40, Marek Vasut ??:
> I doubt so ... but noone ever could test it without DT bindings as you
> NAKed/stalled every single attempt to add the platform binding code. So this
> code was rotting in the tree, who knows how many bugs are still in it. Now I
> guess it's about time to start squashing the bugs.
>
I checked the latest l2-mtd code. The bug does exit if the gpmi-nand 
driver can works(actually it can not).

I will test your patch.
Anyway, this patch should be sent to Artem, not the arm-soc.

thanks
Huang Shijie
