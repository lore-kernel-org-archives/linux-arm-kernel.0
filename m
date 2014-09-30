From: nicoleotsuka@gmail.com (Nicolin Chen)
Date: Tue, 30 Sep 2014 10:42:42 -0700
Subject: [PATCH] ASoC: fsl: fix dependencies for wm8962
In-Reply-To: <20140930164510.GF4273@sirena.org.uk>
References: <1950588.ErdGoiHh8p@wuerfel> <20140930164510.GF4273@sirena.org.uk>
Message-ID: <20140930174241.GA1296@Asurada>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 05:45:10PM +0100, Mark Brown wrote:
> On Tue, Sep 30, 2014 at 01:43:41PM +0200, Arnd Bergmann wrote:
> > The wm8962 driver uses the input subsystem, but is selected by
> > SND_SOC_FSL_ASOC_CARD, which can be built with CONFIG_INPUT disabled,
> > resulting in this link error:
> 
> That select shouldn't be there in the first place, I asked Nicolin to
> fix this when I applied the driver but he's not got round to it yet.

I think I might have missed something around those days, even though
the 'Applied' mail seemly doesn't have any comment against this part:
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-August/080083.html

Is that possible for you to copy and paste the comments again?

Thank you
Nicolin
