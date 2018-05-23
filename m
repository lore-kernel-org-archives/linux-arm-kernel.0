From: tony@atomide.com (Tony Lindgren)
Date: Wed, 23 May 2018 11:52:44 -0700
Subject: [PATCH 3/6] ASoC: ams_delta: use GPIO lookup table
In-Reply-To: <20180521100503.GA24638@sirena.org.uk>
References: <20180518210954.29044-1-jmkrzyszt@gmail.com>
 <20180518210954.29044-3-jmkrzyszt@gmail.com>
 <20180521100503.GA24638@sirena.org.uk>
Message-ID: <20180523185244.GT98604@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mark Brown <broonie@kernel.org> [180521 10:07]:
> On Fri, May 18, 2018 at 11:09:51PM +0200, Janusz Krzysztofik wrote:
> > Now as the Amstrad Delta board provides GPIO lookup tables, switch from
> > GPIO numbers to GPIO descriptors and use the table to locate required
> > GPIO pins.
> 
> Acked-by: Mark Brown <broonie@kernel.org>

Thanks applying patches 1 and 3 of this series into omap-for-v4.18/soc.
It's kind of getting late for v4.18, but let's see if we can still make
it.

Seems the others can be applied to the driver trees after no more
comments, then once all that is done we can apply the last patch
in this series.

Regards,

Tony
