From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 Jul 2013 11:26:44 +0100
Subject: [PATCH] ARM: ARMv7-M: Fix name of NVIC handler function
In-Reply-To: <20130730081507.GO1754@pengutronix.de>
References: <1372238855-26112-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20130708152917.GE29556@pengutronix.de>
 <20130730081507.GO1754@pengutronix.de>
Message-ID: <20130730102643.GP24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 10:15:07AM +0200, Uwe Kleine-K?nig wrote:
> Hi Russell,
> 
> On Mon, Jul 08, 2013 at 05:29:17PM +0200, Uwe Kleine-K?nig wrote:
> > On Wed, Jun 26, 2013 at 11:27:35AM +0200, Uwe Kleine-K?nig wrote:
> > > The name changed in response to review comments for the nvic irqchip
> > > driver when the original name was already accepted into Russell King's
> > > tree.
> > > 
> > > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > > Hello,
> > > 
> > > this patch was part of the irqchip patch v4, but I split it out for
> > > being easier to merge in v5. It applies on top of Russell's devel-stable
> > > branch.
> > > 
> > > Russell: I put it on top of my for-next branch (
> > > 
> > > 	git://git.pengutronix.de/git/ukl/linux.git for-next
> > > 
> > > ) that you merged into your devel-stable some time ago. So assuming
> > > you're fine with the patch, you can just repull or I can put it into
> > > your patch tracker if you prefer it. In the latter case please tell me.
> > The mismatch hit Linus' tree now. How should this patch get to him?
> Although it's not critical (as there are no in-tree users) I still think
> this should go in before 3.11.

Can you put it in the patch system please?
