From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 19 Jun 2013 15:16:11 -0700
Subject: [PATCH v4 06/12] memory: mvebu-devbus: Remove address decoding
 window workaround
In-Reply-To: <20130619201805.GJ31667@titan.lakedaemon.net>
References: <1371672446-21583-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1371672446-21583-7-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130619201805.GJ31667@titan.lakedaemon.net>
Message-ID: <20130619221611.GC9518@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 19, 2013 at 04:18:05PM -0400, Jason Cooper wrote:
> On Wed, Jun 19, 2013 at 05:07:20PM -0300, Ezequiel Garcia wrote:
> > Now that mbus device tree binding has been introduced, remove the address
> > decoding window management from this driver.
> > A suitable 'ranges' entry should be added to the devbus-compatible node in
> > the device tree, as described by the mbus binding documentation.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> > Greg,
> > 
> > I'm Ccing you, since you're carrying the mvebu-devbus driver in your trees.
> > This patch should be applied only after the MBus DT binding is accepted
> > and/or merged; although I doubt we will see that happening any time soon.
> > 
> >  drivers/memory/mvebu-devbus.c | 64 ++-----------------------------------------
> >  1 file changed, 2 insertions(+), 62 deletions(-)
> 
> Since this MBus series is most likely for v3.12, Greg's tree will be
> merged by then.  At which time, we can decide if it's best to keep the
> series together or continue to send devbus changes through him.  I'm
> fine either way, and but I have a preference for keeping the series
> together.

Ok, I'll ignore this then, as it shouldn't go into 3.11, and I don't
have trees that go beyond that at this point in time.

thanks,

greg k-h
