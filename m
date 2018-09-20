From: tony@atomide.com (Tony Lindgren)
Date: Thu, 20 Sep 2018 13:58:05 -0700
Subject: [PATCH v3 0/3] ARM: OMAP1: ams-delta: Complete driver gpiod
 migration
In-Reply-To: <1794253.R1RrZXVNCJ@z50>
References: <20180717231448.14958-1-jmkrzyszt@gmail.com>
 <20180909225605.16463-1-jmkrzyszt@gmail.com>
 <1794253.R1RrZXVNCJ@z50>
Message-ID: <20180920205805.GQ5662@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [180919 18:13]:
> On Monday, September 10, 2018 12:56:02 AM CEST Janusz Krzysztofik wrote:
> > 
> > This is a follow up of initial submission of a series consisted of 
> > 6 changes, 3 of which have been already applied or reworkeed.
> > 
> > 
> > Janusz Krzysztofik (3):
> >       video: fbdev: omapfb: lcd_ams_delta: use GPIO lookup table
> >       mtd: rawnand: ams-delta: use GPIO lookup table
> 
> Hi Tony,
> 
> Please ignore this patch. It may no longer be possible to merged it cleanly 
> with nand/next tree. I'll exclude it from the series, rebase on top of nand/
> next and submit via linux-mtd.

OK sounds good to me.

> That shouldn't affect the two remaining patches of the series which should 
> still apply and merge cleanly, but I can resend them renumbered if you wish.

Up to the mtd and fb folks as far as I'm concerned :)

Regards,

Tony
