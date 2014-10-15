From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 15 Oct 2014 11:30:49 -0400
Subject: [PATCH 0/8] Armada XP pinctrl consolidation and ix4-300d fixes
In-Reply-To: <20141015145539.GB18413@lunn.ch>
References: <20141003141102.GJ3895@titan.lakedaemon.net>
 <542EBB93.108@gmail.com>
 <A9781A2E-F3CA-4E8A-833C-D167B456D9F7@perenite.com>
 <542EC3A3.1060605@gmail.com>
 <1ACB5318-863E-40D8-8B27-41F1C0D0A4B8@perenite.com>
 <5432BFB1.2060300@gmail.com>
 <CE7A9795-C2AF-451A-8018-3A0B8788BF60@perenite.com>
 <20141015144259.GB17447@titan.lakedaemon.net>
 <543E898D.10606@gmail.com> <20141015145539.GB18413@lunn.ch>
Message-ID: <20141015153049.GE17447@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 15, 2014 at 04:55:39PM +0200, Andrew Lunn wrote:
> > >Do you have a link to an email thread or the patch Subject line?  I can
> > >confirm it's missing from mvebu/fixes...
> > 
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/275487.html
> > 
> > But you and Andrew should check what Arnd suggested. IIRC, there
> > was also an appropriate follow-up patch discussion started by
> > Andrew.
> 
> There was a lot of back and forth with Arnd. In the end, he gave up
> arguing because too many voices did not like his solution. So my
> original version stands.

Yes, this appears to have been a mistake on my part.  In the
conversation regarding patch #2 of V2, you said you were going to work
on implementing something and would report back.  I applied that to the
whole series instead of just to the second patch.  At any rate, applied
to mvebu/fixes now.

> However, the patch at the end of 
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/275528.html
> 
> is useful, and it would be nice if it could be merged as well.

I'll take a look.

thx,

Jason.
