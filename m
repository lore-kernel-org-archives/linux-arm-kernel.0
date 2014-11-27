From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Nov 2014 17:51:58 +0100
Subject: Code generation involving __raw_readl and __raw_writel
In-Reply-To: <yw1x1toofwhf.fsf@unicorn.mansr.com>
References: <5476FFA2.8010403@free.fr> <5477496F.7040807@free.fr>
 <yw1x1toofwhf.fsf@unicorn.mansr.com>
Message-ID: <5308846.uKgsdBdD5V@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 November 2014 16:18:20 M?ns Rullg?rd wrote:
> Mason <mpeg.blue@free.fr> writes:
> 
> > On 27/11/2014 16:36, M?ns Rullg?rd wrote:
> >
> >> Arnd Bergmann wrote:
> >>
> >>> Would you consider submitting the code upstream?
> >>
> >> This appears to be targeting a Sigma Designs chip, and nobody has
> >> to my knowledge ever seen anything go upstream from them.
> >
> > Well, I do hope to push as much as I can into the vanilla kernel.
> > (That is what "to submit the code upstream" means, right?)
> 
> That's great.  You mentioned working against 3.14.  Do you have any
> plans to move onto the current version?  That would be a prerequisite
> for upstream acceptance.

FWIW, it's also a good strategy to do the initial bringup on the latest
kernel and then backport to the older one for product work, otherwise
you end up doing the forward port twice, and it's almost always harder
than a backport.

	Arnd
