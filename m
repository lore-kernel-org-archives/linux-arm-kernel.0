From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 1 Jun 2015 23:07:02 +0200
Subject: QNAP TS-419: sata_mv fails to initialise with "can't set global
 reset"
In-Reply-To: <1433192857.5748.288.camel@debian.org>
References: <1433068534.5748.276.camel@debian.org>
 <20150601025050.GB11354@lunn.ch>
 <1433192857.5748.288.camel@debian.org>
Message-ID: <20150601210702.GN22739@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 01, 2015 at 10:07:37PM +0100, Ian Campbell wrote:
> On Mon, 2015-06-01 at 04:50 +0200, Andrew Lunn wrote:
> > You might also want to try 
> > 
> > http://comments.gmane.org/gmane.linux.ports.arm.kernel/416589
> > 
> > In particular the first patch.
> 
> That did the trick, thanks!

Great.

A tested-by: for that patch will help grease the path into the kernel.

Thanks
	Andrew
