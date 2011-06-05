From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Sun, 5 Jun 2011 11:59:48 +0300
Subject: [PATCH v2 1/5] ep93xx: set DMA masks for the ep93xx_eth
In-Reply-To: <20110605083445.GT16318@ibawizard.net>
References: <f20d8fe52f823e7e65423720c53f2935d3e08967.1307040443.git.mika.westerberg@iki.fi>
	<20110605083445.GT16318@ibawizard.net>
Message-ID: <20110605085948.GB16018@acer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 05, 2011 at 10:34:45AM +0200, Petr ?tetiar wrote:
> 
> do you have the series available somewhere for pull? I would like to test the
> changes for you on my ts7250/ts7300, but I'm quite lazy and would like to just
> cherry-pick the changes if possible :-)

Unfortunately - no. But what's wrong with 'git am <mbox>'? ;-)

> I also wonder, why this patch[1] from Herbert Valerio Riedel has never made it
> upstream, this email[2] is the last trace of the patch I could find. Looks
> like Herbert did few fixes to the driver and thanks to Matthieu, I'm using
> this forward ported patch[3] since today, without any problems.

I have no idea.

It looks like David Miller (CC'd) has been taking care of ep93xx_eth.c maybe
he knows this better.

> Do you personaly use the ethernet on the ep93xx/ts72xx heavily?

Yes, I have NFS roots for the boards so it is essential for me.
