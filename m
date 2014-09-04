From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 4 Sep 2014 07:40:46 -0400
Subject: ARM: Kirkwood: mach-kirkwood's removal
In-Reply-To: <1409821676.5546.77.camel@x220>
References: <1405328105.8281.27.camel@x220>
 <20140714121524.GO13108@titan.lakedaemon.net>
 <1409821676.5546.77.camel@x220>
Message-ID: <20140904114046.GQ30467@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 04, 2014 at 11:07:56AM +0200, Paul Bolle wrote:
> On Mon, 2014-07-14 at 08:15 -0400, Jason Cooper wrote:
> > On Mon, Jul 14, 2014 at 10:55:05AM +0200, Paul Bolle wrote:
> > > 1) The code it removes includes the Kconfig entries for
> > >     ARCH_KIRKWOOD
> > >     MACH_OPENRD_CLIENT
> > >     MACH_OPENRD_ULTIMATE
> > >     MACH_T5325
> > > 
> > > There are a few references to these Kconfig symbols still left in the
> > > tree. Are patches to remove these references queued somewhere?
> > 
> > Yes, those patches are to drivers and sub-systems.  They are going
> > through the respective trees.  You can see the whole series at:
> > 
> >   https://lkml.kernel.org/r/1405028192-9623-1-git-send-email-andrew at lunn.ch
> 
> References to ARCH_KIRKWOOD can still be seen in v3.17-rc3 and
> next-20140903. But Andrew recently sent out another batch of patches to
> remove these too:
> http://marc.info/?i=1409417172-6846-1-git-send-email-andrew at lunn.ch

Yep, that's because I asked him to. ;-)  Unfortunately, I haven't had
time to apply them to a branch yet.  Shortly though.

thx,

Jason.
