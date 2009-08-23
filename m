From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Sun, 23 Aug 2009 19:45:39 +0200
Subject: [alsa-devel] [RFC][PATCH 1/3 v2] ARM: OMAP: DMA: Add support for
	DMA channel self linking on OMAP1510
In-Reply-To: <20090823170359.GA3488@sirena.org.uk>
References: <200908101050.02530.jkrzyszt@tis.icnet.pl>
	<200908231756.13016.jkrzyszt@tis.icnet.pl>
	<20090823170359.GA3488@sirena.org.uk>
Message-ID: <200908231945.40187.jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sunday 23 August 2009 19:03:59 Mark Brown wrote:
> It's not that it's not fair, at this point it's not possible - please
> make any changes you feel are required against current ASoC.  The patch
> has been applied for a little while now and is buried quite deep in the
> already published history.

Mark,

I see your point. It also seemed to me that you had already applied my 
original patch, however while preparing that v2 I found no single evidence of 
it being applied, so took into consideration it was not my patch I had on my 
mind but Eduardo's patches on OMAP McBSP that you had agreeed with Tony to 
push via ASoC tree. The last message regarding this original patch I am able 
to locate was from Jarkko[1], where he said it would be better to leave this 
one in Tony's hands.

If I missed something and my original patch has really been applied, I'll be 
happy to prepare a new version that reverts previos changes and makes those 
proposed in patch v2, if those are acceptable.

Thanks,
Janusz

[1] http://www.spinics.net/lists/linux-omap/msg17172.html
