From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 24 Jan 2016 00:02:01 +0100
Subject: [PATCH] ARM: pxa: let PXA27x select PINCTRL
In-Reply-To: <87k2n0ar0v.fsf@belgarion.home>
References: <1453577004-15295-1-git-send-email-yamada.masahiro@socionext.com>
 <87k2n0ar0v.fsf@belgarion.home>
Message-ID: <1495788.v3fMfHFcmP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 23 January 2016 23:07:44 Robert Jarzmik wrote:
> I have this patch in my local tree for 2 monthes (see [1]). This is the patch
> I'd rather have. I had not posted it as I didn't think the pinctrl work was over
> yet. I know at least that pxa3xx is ready (as pinctrl-single should be used),
> and I had not the time to create the map for pxa25x.

Once you are done, does that mean the plat-pxa/mfp.c stuff becomes
completely unused on pxa, or will it coexist with pinctrl?

I'm asking because it seems that at that point, the entire plat-pxa
directory can be removed, with the dma.c and ssp.c files getting
moved to mach-pxa, and mfp.c moved to mach-mmp. :-)

	Arnd
