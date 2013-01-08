From: simon.guinot@sequanux.org (Simon Guinot)
Date: Tue, 8 Jan 2013 18:51:48 +0100
Subject: [PATCH] ARM: Kirkwood: convert ns2 boards to pinctrl
In-Reply-To: <20130108170736.GV5075@titan.lakedaemon.net>
References: <1357655778-32066-1-git-send-email-simon.guinot@sequanux.org>
 <20130108161553.GE3392@lunn.ch>
 <20130108161835.GN1357@kw.sim.vm.gnt>
 <20130108163015.GF3392@lunn.ch>
 <20130108163909.GU5075@titan.lakedaemon.net>
 <20130108165554.GO1357@kw.sim.vm.gnt>
 <20130108170736.GV5075@titan.lakedaemon.net>
Message-ID: <20130108175148.GP1357@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 08, 2013 at 12:07:36PM -0500, Jason Cooper wrote:
> On Tue, Jan 08, 2013 at 05:55:54PM +0100, Simon Guinot wrote:
> > On Tue, Jan 08, 2013 at 11:39:09AM -0500, Jason Cooper wrote:
> > > On Tue, Jan 08, 2013 at 05:30:15PM +0100, Andrew Lunn wrote:
> > > > > Do you think it is still possible to merge this patch as a bug fix for
> > > > > the current release ?
> > > > 
> > > > Hi Simon
> > > > 
> > > > The commit log will need some explanation why this is a fix. It
> > > > currently looks like it just a conversion. Document what actually goes
> > > > wrong and how this fixes it.
> > > 
> > > hmm, I could change the patch subject to:
> > > 
> > > -ARM: Kirkwood: convert ns2 boards to pinctrl
> > > +ARM: Kirkwood: fix gpio by converting ns2 boards to pinctrl
> > > 
> > > That's basically what the body says.  Sound good?
> > 
> > It would be perfect for me.
> > 
> 
> On second thought, I'll do "fix ns2 gpios by converting to pinctrl"

OK, thanks.

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130108/95db0972/attachment.sig>
