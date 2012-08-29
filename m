From: eric@eukrea.com (Eric =?ISO-8859-1?B?QuluYXJk?=)
Date: Wed, 29 Aug 2012 17:28:20 +0200
Subject: mxc_nand.c on mach-imx/imx53
In-Reply-To: <503E3331.8050203@antcom.de>
References: <5035F84E.3000901@antcom.de>
 <20120829074122.GV26594@pengutronix.de>
 <503E3331.8050203@antcom.de>
Message-ID: <20120829172820.43bbe68e@eb-e6520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roland,

Le Wed, 29 Aug 2012 17:20:17 +0200,
Roland Stigge <stigge@antcom.de> a ?crit :
> Using  ".ecclayout_4k = &nandv2_hw_eccoob_4k" also doesn't work. So is
> there any hint how I can proceed from here? Any plans or hint regarding
> the "XXX"?
> 
you may need something like this patch from barebox :
http://git.pengutronix.de/?p=barebox.git;a=commit;h=632c45795065e6a7471ab82be38e808eb6204341

I may have time to adapt this next week but if you have time before feel
free to do it ;-)

Eric
