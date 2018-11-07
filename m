From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 7 Nov 2018 21:56:21 +0100 (CET)
Subject: [PATCH 2/2] mm/sparse: add common helper to mark all memblocks
 present
In-Reply-To: <20181107123838.1b7234c98a87dec5a2b25e67@linux-foundation.org>
References: <20181107173859.24096-1-logang@deltatee.com>
 <20181107173859.24096-3-logang@deltatee.com>
 <20181107121207.62cb37cf58484b7cc80a8fd8@linux-foundation.org>
 <724be9bb-59b6-33f3-7b59-3ca644d59bf7@deltatee.com>
 <alpine.DEB.2.21.1811072125280.1666@nanos.tec.linutronix.de>
 <b1cc442e-7314-4a8e-3eec-9adc200d7582@deltatee.com>
 <20181107123838.1b7234c98a87dec5a2b25e67@linux-foundation.org>
Message-ID: <alpine.DEB.2.21.1811072153590.1666@nanos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 7 Nov 2018, Andrew Morton wrote:
> On Wed, 7 Nov 2018 13:36:34 -0700 Logan Gunthorpe <logang@deltatee.com> wrote:
> 
> > > Actually if both names suck, then there also is the option to rename both
> > > instead of adding a comment to explain the suckage.
> > 
> > Ok, well, I wasn't expecting to take on a big rename like that as it
> > would create a patch touching a bunch of arches and mm files... But if
> > we can come to some agreement on a better name and someone is willing to
> > take that patch without significant delay then I'd be happy to create
> > the patch and add it to the start of my series.
> 
> Some other time ;)

More precise: Manjana. You live way too close to Mexico :)
