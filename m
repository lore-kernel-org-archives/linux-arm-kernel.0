From: ijc@debian.org (Ian Campbell)
Date: Tue, 02 Jun 2015 08:14:52 +0100
Subject: QNAP TS-419: sata_mv fails to initialise with "can't set global
 reset"
In-Reply-To: <20150601210702.GN22739@lunn.ch>
References: <1433068534.5748.276.camel@debian.org>
 <20150601025050.GB11354@lunn.ch> <1433192857.5748.288.camel@debian.org>
 <20150601210702.GN22739@lunn.ch>
Message-ID: <1433229292.5748.291.camel@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-06-01 at 23:07 +0200, Andrew Lunn wrote:
> On Mon, Jun 01, 2015 at 10:07:37PM +0100, Ian Campbell wrote:
> > On Mon, 2015-06-01 at 04:50 +0200, Andrew Lunn wrote:
> > > You might also want to try 
> > > 
> > > http://comments.gmane.org/gmane.linux.ports.arm.kernel/416589
> > > 
> > > In particular the first patch.
> > 
> > That did the trick, thanks!
> 
> Great.
> 
> A tested-by: for that patch will help grease the path into the kernel.

I think it's already been applied to Gregory's tree, but I replied with
a T-b anyway.

Thanks again,
Ian.
