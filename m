From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 1 Oct 2013 11:03:52 -0400
Subject: [PATCH v3 1/2] ARM: feroceon: Add suspend/resume operation
In-Reply-To: <20131001134428.GD2448@localhost>
References: <1377186547-14284-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1377186547-14284-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131001133850.GR31178@titan.lakedaemon.net>
 <20131001134428.GD2448@localhost>
Message-ID: <20131001150352.GU31178@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 10:44:29AM -0300, Ezequiel Garcia wrote:
> Jason,
> 
> On Tue, Oct 01, 2013 at 09:38:50AM -0400, Jason Cooper wrote:
> > +rmk (oops, forgot to add you the first time around)
> > 
> > On Thu, Aug 22, 2013 at 12:49:06PM -0300, Ezequiel Garcia wrote:
> > > Add support for suspend/resume operations. The implemented procedures
> > > are identical to the ones for ARM926.
> > > 
> > > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > > ---
> > >  arch/arm/Kconfig            |  2 +-
> > >  arch/arm/mm/proc-feroceon.S | 26 ++++++++++++++++++++++++++
> > >  2 files changed, 27 insertions(+), 1 deletion(-)
> > 
> > Russell,
> > 
> > This is pretty isolated, and the next patch in the series depends on it
> > for building (it's changes are all in mach-kirkwood/).  Should Ezequiel
> > push this into your patch tracker (and then could you create a public,
> > non-rebasable branch containing it?), or can I take it with your Ack?
> > 
> 
> This one is already sitting happy in Linus' :-)

Ah, very well then.  I'll queue up the other one.

thx,

Jason.
