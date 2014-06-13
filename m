From: balbi@ti.com (Felipe Balbi)
Date: Fri, 13 Jun 2014 18:10:19 -0500
Subject: [RESEND PATCH 1/2] ARM: AM43xx: hwmod: add DSS hwmod data
In-Reply-To: <alpine.DEB.2.02.1406131910060.340@utopia.booyaka.com>
References: <1402676147-3711-1-git-send-email-balbi@ti.com>
 <1402676147-3711-2-git-send-email-balbi@ti.com>
 <20140613162323.GH8319@saruman.home>
 <alpine.DEB.2.02.1406131910060.340@utopia.booyaka.com>
Message-ID: <20140613231019.GA24121@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 13, 2014 at 07:11:58PM +0000, Paul Walmsley wrote:
> > > From: Sathya Prakash M R <sathyap@ti.com>
> > > 
> > > Add DSS hwmod data for AM43xx.
> > > 
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Acked-by: Rajendra Nayak <rnayak@ti.com>
> > > Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
> > > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > ---
> > > 
> > > Note that this patch was originally send on May 9th [1], changes were requested
> > > and a new version was sent on May 19th [2], then on May 27th [3] Tomi pinged
> > > maintainer again and go no response.
> > > 
> > > Without this patch, we cannot get display working on any AM437x devices.
> > > 
> > > [1] http://marc.info/?l=linux-arm-kernel&m=139963677925227&w=2
> > > [2] http://marc.info/?l=linux-arm-kernel&m=140049799425512&w=2
> > > [3] http://marc.info/?l=linux-arm-kernel&m=140117232826754&w=2
> > > 
> > >  arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 98 ++++++++++++++++++++++++++++++
> > >  arch/arm/mach-omap2/prcm43xx.h             |  1 +
> > >  2 files changed, 99 insertions(+)
> 
> Sorry for the delay on this.  Have been corresponding with TI management 
> to figure out what to do about patches for AM43xx.  I don't have boards or 
> public documentation for these devices, so it's impossible for me to 
> meaningfully review the patches.  Looks like boards and/or public docs 
> won't be coming any time soon.
> 
> So for my part, here's what I'll need to merge any hwmod or PRCM patches 
> that involve AM437x:
> 
> 1. A Reviewed-by: from one of the following folks (which should come from
> a different person than who is submitting the patches):
> 
> Roger Quadros
> Nishanth Menon
> Rajendra Nayak
> Kevin Hilman
> Tony Lindgren
> 
> 2. A Tested-by: from one of the following folks (who can be the same as 
> the person who is the same as the person who is submitting the patches):
> 
> Nishanth Menon
> Rajendra Nayak
> Kevin Hilman 
> Tony Lindgren

What you're saying here is that it's pointless for anybody else in TI to
review and/or test patches because you will only accept such tags from
this list of 4 ~ 5 people. It doesn't take a brain surgeon to note how
this won't scale and, if you continue to ignore patches during the
entire development cycle and only reply after it's too late for $this
merge window, it won't help much.

Quite frankly, it's very upsetting to see an affirmation that all the
work that I (personally) and many others do is seen as "pointless" from
your side *unless* it gets the blessing from the few folks listed above.

This just makes it ever more difficult for anything, which is clearly
*BROKEN* to be fixed upstream and will just contribute to people
vanishing from mainline development.

The very fact that you will only accept patches blessed by the gang-of-4
goes against the very foundations of open source development. Just
because you don't have access to documentation - and granted, that
_does_ make things a lot more difficult - does not mean you have to
consider an entire company as a non-trust worthy organization. Specially
when there are so many here who have been doing mainline development for
quite some time.

Anyway, whatever... I just hope that if we go through *another* merge
window without $subject being merged, someone takes the patch because
this already has a ridiculous amount of bureaucratic bariers to patches
which are, to put it very bluntly, *CORRECT*.

ps: $subject in particular, has been tested by 3 different people.
Actually 4, if you consider Darren Etheridge who used $subject to help
me get display working on AM437x SK.

pps: Darren, can you reply with your (according to Paul) pointless
Tested-by ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140613/8304dc2f/attachment.sig>
