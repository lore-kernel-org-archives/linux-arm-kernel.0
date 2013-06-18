From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 18 Jun 2013 14:17:31 +0200
Subject: [PATCH v3 06/12] memory: mvebu-devbus: Remove address decoding
 window workaround
In-Reply-To: <20130618113920.GW31667@titan.lakedaemon.net>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1371554737-25319-7-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130618113920.GW31667@titan.lakedaemon.net>
Message-ID: <20130618141731.56e7966c@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Tue, 18 Jun 2013 07:39:20 -0400, Jason Cooper wrote:
> On Tue, Jun 18, 2013 at 08:25:31AM -0300, Ezequiel Garcia wrote:
> > Now that mbus device tree binding has been introduced, remove the address
> > decoding window management from this driver.
> > A suitable 'ranges' entry should be added to the devbus-compatible node in
> > the device tree, as described by the mbus binding documentation.
> > 
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >  drivers/memory/mvebu-devbus.c | 64 ++-----------------------------------------
> >  1 file changed, 2 insertions(+), 62 deletions(-)
> 
> Unfortunately, the patch adding mvebu-devbus is going through gregkh's
> tree.  Either this patch needs to wait for v3.12, or ask Greg if he can
> take this one.

I believe that what we're looking for right now is a Acked-by from both
the Marvell maintainers, Arnd Bergmann and Jason Gunthorpe. Once we get
those Acked-by, we can figure out the merge strategy for this patch
set.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
