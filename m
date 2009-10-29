From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Fri, 30 Oct 2009 00:47:17 +0100
Subject: [PATCH] OMAP1: PM: Fix omapfb/lcd on Amstrad Delta broken when PM
	set
In-Reply-To: <200910292339.48610.jkrzyszt@tis.icnet.pl>
References: <200910292339.48610.jkrzyszt@tis.icnet.pl>
Message-ID: <200910300047.20049.jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thursday 29 October 2009 23:39:44 Janusz Krzysztofik napisa?(a):
>
> Since PM area is quite new to me, I am not sure if there may be a better
> solution. AFAICS, the standard way to prevent an ARM_CLKCT1 bit being

s/ARM_CLKCT1/ARM_IDLECT1/

> switched to idle is to enable a clock that uses it (tipb_ck, dma_ck, or
> tc_ck or one of its children in this case, right?).

Janusz
