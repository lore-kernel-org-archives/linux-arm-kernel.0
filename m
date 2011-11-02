From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 2 Nov 2011 08:00:42 +0100
Subject: [PATCH] dt: add empty of_alias_get_id() for non-dt builds
In-Reply-To: <20111029114905.GA22592@ponder.secretlab.ca>
References: <1319706448-1664-1-git-send-email-nicolas.ferre@atmel.com>
	<4EAAABF6.50803@gmail.com>
	<20111029114905.GA22592@ponder.secretlab.ca>
Message-ID: <20111102070042.GA7136@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13:49 Sat 29 Oct     , Grant Likely wrote:
> On Fri, Oct 28, 2011 at 08:19:50AM -0500, Rob Herring wrote:
> > On 10/27/2011 04:07 AM, Nicolas Ferre wrote:
> > > Add function of_alias_get_id() reporting -ENOSYS
> > > for non-dt builds, so that drivers migrating to dt
> > > can save some '#ifdef CONFIG_OF'.
> > > 
> > > Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > 
> > Acked-by: Rob Herring <rob.herring@calxeda.com>
> 
> Merged, thanks
> 
> Rob, for stuff like this, please do pick it up into your git tree and
> reply saying that you've done so.  Then I know I can ignore it because
> I'll be receiving a pull req from you in short order.
> 
> Similarly, I reply whenever I pick up a patch, so you'll know if I've
> already delt with it.
this is still missing in the mainline kernel

the at91 ends broken can one of you send a pull with it to Linus

Best Regards,
J.
