From: pavel@denx.de (Pavel Machek)
Date: Mon, 14 Jul 2014 14:34:16 +0200
Subject: socfpga/sockit ethernet problems
In-Reply-To: <53BBA219.8000607@roese.nl>
References: <20140507104518.GB18139@amd.pavel.ucw.cz>
 <20140703093548.GA9937@amd.pavel.ucw.cz>
 <1404764751.14294.3.camel@linux-builds1>
 <20140707214340.GA29061@amd.pavel.ucw.cz>
 <53BBA219.8000607@roese.nl>
Message-ID: <20140714123416.GF14300@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >Are there suitable default values?
> >
> >u-boot uses these defaults:
> >
> >include/configs/socfpga_common.h:#define CONFIG_KSZ9021_CLK_SKEW_VAL
> >0xf0f0
> >include/configs/socfpga_common.h:#define CONFIG_KSZ9021_DATA_SKEW_VAL
> >0x0
> >
> >...that should correspond to txc-skew-ps == rxc-skew-ps == 3000, all
> >other skew values == 0?
> >
> >Could someone with socrates board and network problems test if this
> >makes any difference?
> 
> SoCrates uses a different PHY, the Lantiq PEF7071 (PHY11G). So those
> dts additions have no effect on SoCrates.

Oops, I guess I was confused.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
