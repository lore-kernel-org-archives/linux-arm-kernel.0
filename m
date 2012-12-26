From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 26 Dec 2012 10:56:04 +0800
Subject: [PATCH 3/3] mmc: esdhc i.MX: Support 8bit mode
In-Reply-To: <m3fw66legd.fsf@pullcord.laptop.org>
References: <1348471345-30785-1-git-send-email-s.hauer@pengutronix.de>
 <1348471345-30785-4-git-send-email-s.hauer@pengutronix.de>
 <20120925071505.GG27291@S2101-09.ap.freescale.net>
 <20120925072714.GY1322@pengutronix.de>
 <20120925073317.GI27291@S2101-09.ap.freescale.net>
 <20120925073808.GZ1322@pengutronix.de>
 <m3k3vilety.fsf@pullcord.laptop.org>
 <20120925075309.GL27291@S2101-09.ap.freescale.net>
 <m3fw66legd.fsf@pullcord.laptop.org>
Message-ID: <20121226025601.GF25478@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2012 at 04:00:18AM -0400, Chris Ball wrote:
> Hi,
> 
> On Tue, Sep 25 2012, Shawn Guo wrote:
> > On Tue, Sep 25, 2012 at 03:52:09AM -0400, Chris Ball wrote:
> >> We could also break the stalemate by just changing the common spec to
> >> have bus-width become optional, default 4.  It's not going to break the
> >> code of anyone who's been treating it as required.  I don't think there
> >> there was a principled reason behind making it required.
> >> 
> > That would be the best :)
> 
> Ah, but sdhci-s3c and dw_mmc have been assuming that bus-width defaults
> 1 when it's not supplied.  That's going to make it complicated.
> 
Okay, we will do the same for esdhc driver, and also submit a change to
the common binding to make it clear.

Shawn
