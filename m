From: rui.zhang@intel.com (Zhang Rui)
Date: Thu, 26 Jul 2018 10:00:41 +0800
Subject: [PATCH v3 00/23] Add multi-channel support to Armada thermal
 driver
In-Reply-To: <20180725095222.054f1e80@xps13>
References: <20180716144206.30985-1-miquel.raynal@bootlin.com>
 <20180718172849.30b7cec0@xps13> <20180725095222.054f1e80@xps13>
Message-ID: <1532570441.2358.27.camel@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ?, 2018-07-25 at 09:52 +0200, Miquel Raynal wrote:
> Hi Eduardo, Zhang,
> 
> Miquel Raynal <miquel.raynal@bootlin.com> wrote on Wed, 18 Jul 2018
> 17:28:49 +0200:
> 
> > 
> > Hi Eduardo,
> > 
> > Miquel Raynal <miquel.raynal@bootlin.com> wrote on Mon, 16 Jul 2018
> > 16:41:43 +0200:
> > 
> > > 
> > > The only capability of the Armada thermal driver is currently
> > > just to
> > > read one sensor (the default one) per AP and one per CP.
> > > Actually,
> > > there is one sensor per core in the AP806 plus one sensor in the
> > > thermal IP itself. The CP110 just features one thermal sensor in
> > > its
> > > own thermal IP.
> > > 
> > > This series first improves the readability of this driver, then
> > > adds
> > > support for multi-channel thermal IPs. The bindings and the
> > > device-trees are updated accordingly.
> > > 
> > > Thank you,
> > > Miqu?l??
> > I know I sent this series on monday but there was almost no change
> > on
> > it (see below), do you think you will have the time to look at it
> > before it's too late for the merge window?
> I know a little bit what it is to be on the maintainer side of a
> subsystem but these changes are laying since April, 21st and I really
> expect to get them merged. Zhang, as Eduardo seems to be overloaded
> this release, could you please take the series?
> 
> Of course if there are things to address I'll be happy to do so.
> 
I had a sync with Eduardo during last merge window, and we agreed to
send separate git pull requests to Linus since this release and see how
it works.
This means that all the soc thermal driver patches should go to
Eduardo' tree and then Linus' tree directly.

Anyway, let's ping Eduardo and see if he can review/take the patches.

thanks,
rui
> Thanks,
> Miqu?l
