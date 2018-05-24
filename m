From: jmkrzyszt@gmail.com (Janusz Krzysztofik)
Date: Thu, 24 May 2018 22:35:04 +0200
Subject: [PATCH 3/6] ASoC: ams_delta: use GPIO lookup table
In-Reply-To: <20180523185244.GT98604@atomide.com>
References: <20180518210954.29044-1-jmkrzyszt@gmail.com>
 <20180521100503.GA24638@sirena.org.uk> <20180523185244.GT98604@atomide.com>
Message-ID: <1875447.uBIO10iqcO@z50>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, May 23, 2018 8:52:44 PM CEST Tony Lindgren wrote:
> * Mark Brown <broonie@kernel.org> [180521 10:07]:
> > On Fri, May 18, 2018 at 11:09:51PM +0200, Janusz Krzysztofik wrote:
> > > Now as the Amstrad Delta board provides GPIO lookup tables, switch from
> > > GPIO numbers to GPIO descriptors and use the table to locate required
> > > GPIO pins.
> > 
> > Acked-by: Mark Brown <broonie@kernel.org>
> 

Hi Tony,

> Thanks applying patches 1 and 3 of this series into omap-for-v4.18/soc.
> It's kind of getting late for v4.18, but let's see if we can still make
> it.

Thank you.

> Seems the others can be applied to the driver trees after no more
> comments, then once all that is done we can apply the last patch
> in this series.

I'll be submitting v2 of 5/6 (nand) very soon. 4/6 (lcd) is still waiting for 
Tomi to respond. I hope there will be no issues with it. Howevver, regarding 
2/6 - serio - I have to work more on that to satisfy Dmitry's comments. So 
let's forget about 6/6 for now and I'll resubmit it again when we are ready 
for that. Meanwhile, I'm going to submit a few more patches against the board 
init file to complete migration to GPIO descriptors so dynamic allocation of 
GPIO numbers to ams-delta latches will be possible.

Thanks,
Janusz
