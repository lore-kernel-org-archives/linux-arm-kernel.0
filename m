From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Sep 2015 15:58:31 +0200
Subject: [PATCH 0/5] ARM: sunxi: Introduce CHIP support
In-Reply-To: <20150918135538.GS4684@lukather>
References: <1442566130-3497-1-git-send-email-maxime.ripard@free-electrons.com>
 <13485899.XsimukeSAF@wuerfel> <20150918135538.GS4684@lukather>
Message-ID: <29444326.E66iiSTYyO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 September 2015 15:55:38 Maxime Ripard wrote:
> 
> And I don't think it's something the MMC core should deal with. The
> device itself has a single pin to provide its power, it's the board
> that is wired that way. The way I was seeing it was more that I needed
> to create a regulator driver that would take two inputs, that the mmc
> core would use. Last time I discussed it with Mark (Brown), it semes
> like he was open to the idea, so I just need to find some time to do
> just that.
> 

Ok, fair enough.

	Arnd
