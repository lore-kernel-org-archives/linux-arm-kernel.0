From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Thu, 16 Jun 2016 10:44:18 +0000
Subject: [PATCH 3/3] ARM: dts: imx7: add Toradex Colibri iMX7S/iMX7D
 support
In-Reply-To: <59f88a185c67034087f3eabf88da6c8c@agner.ch>
References: <20160608023709.32090-1-stefan@agner.ch>
 <20160608023709.32090-4-stefan@agner.ch> <20160612023100.GW20243@tiger>
 <59f88a185c67034087f3eabf88da6c8c@agner.ch>
Message-ID: <1466073856.3884.11.camel@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sali Stefan

On Wed, 2016-06-15 at 22:37 -0700, Stefan Agner wrote:
> On 2016-06-11 19:31, Shawn Guo wrote:
> > 
> > On Tue, Jun 07, 2016 at 07:37:09PM -0700, Stefan Agner wrote:
> > > 
> > <snip>
> > > 
> > > +/ {
> > > +	model = "Toradex Colibri iMX7D on Colibri Evaluation
> > > Board V3";
> > > +	compatible = "toradex,colibri_imx7d-eval",
> > > "toradex,colibri_imx7d", \
> > We always use hyphen than underscore in compatible string.
> We always used underscores, this goes back to the first Colibri
> specific
> device tree: tegra20-iris-512.dts.
> 
> I would rather prefer to not change this for the sake of
> consistency...
> What do you think?

I have been there before when submitting a first Apalis TK1 version:

https://lkml.org/lkml/2016/5/16/288

Upon Rob Herring's suggestion I changed it now all to dashes:

https://lkml.org/lkml/2016/5/27/399

Even in our downstream U-Boot:

http://git.toradex.com/cgit/u-boot-toradex.git/commit/?h=2015.04-torade
x-next&id=4ae2e657f3350422ad81b1632de156bdd9517206

Of course for Colibri iMX7 one could argue that we already sold a
couple hundred pieces still using underscores. However I guess we could
still change to dashes now as those were all prototype, sample and/or
beta.

Cheers

Marcel
