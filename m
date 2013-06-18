From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 18 Jun 2013 08:33:54 -0400
Subject: [PATCH v3 06/12] memory: mvebu-devbus: Remove address decoding
 window workaround
In-Reply-To: <20130618141731.56e7966c@skate>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1371554737-25319-7-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130618113920.GW31667@titan.lakedaemon.net>
 <20130618141731.56e7966c@skate>
Message-ID: <20130618123354.GX31667@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 02:17:31PM +0200, Thomas Petazzoni wrote:
> Dear Jason Cooper,
> 
> On Tue, 18 Jun 2013 07:39:20 -0400, Jason Cooper wrote:
> > On Tue, Jun 18, 2013 at 08:25:31AM -0300, Ezequiel Garcia wrote:
> > > Now that mbus device tree binding has been introduced, remove the address
> > > decoding window management from this driver.
> > > A suitable 'ranges' entry should be added to the devbus-compatible node in
> > > the device tree, as described by the mbus binding documentation.
> > > 
> > > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > > ---
> > >  drivers/memory/mvebu-devbus.c | 64 ++-----------------------------------------
> > >  1 file changed, 2 insertions(+), 62 deletions(-)
> > 
> > Unfortunately, the patch adding mvebu-devbus is going through gregkh's
> > tree.  Either this patch needs to wait for v3.12, or ask Greg if he can
> > take this one.
> 
> I believe that what we're looking for right now is a Acked-by from both
> the Marvell maintainers, Arnd Bergmann and Jason Gunthorpe. Once we get
> those Acked-by, we can figure out the merge strategy for this patch
> set.

Right.  I was more looking to give Ezequiel a heads up because I think
he will have to extract devbus related changes out of the patches later
in this series.  I haven't had time to look closely yet, but wanted to
toss it out there so it didn't rear it's head later and throw things off
track.

thx,

Jason.
