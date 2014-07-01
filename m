From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 1 Jul 2014 08:23:48 -0400
Subject: [PATCH V4 00/16] irqchip: crossbar: Driver fixes
In-Reply-To: <53B28124.40509@ti.com>
References: <1403766634-18543-1-git-send-email-r.sricharan@ti.com>
 <20140630192910.GA23978@titan.lakedaemon.net>
 <20140701075930.GN28884@atomide.com> <53B28124.40509@ti.com>
Message-ID: <20140701122348.GE23978@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 03:06:36PM +0530, Sricharan R wrote:
> Hi Tony,
> 
> On Tuesday 01 July 2014 01:29 PM, Tony Lindgren wrote:
> > * Jason Cooper <jason@lakedaemon.net> [140630 12:30]:
> >>
> >> Whole series applied to irqchip/crossbar, I'll give it a day or two in
> >> -next, then I'll merge it into irqchip/core.
> >>
> >> Tony: Right now, it's immutable unless you tell me I applied something
> >> incorrectly.  Once it goes into irqchip/core, it's immutable no matter
> >> what you say. ;-)
> > 
> > Thanks, looks good to me. Sricharan and Nishant, can you please
> > check that we can now apply the related .dts changes on top of
> > Jason's branch at:
> > 
> > git://git.infradead.org/users/jcooper/linux.git irqchip/crossbar
> > 
> 
> I applied the dts patches on top of this and it worked fine for
> me on dra72 evm

Awesome, thanks.  irqchip/crossbar has been merged into irqchip/core.

thx,

Jason.
