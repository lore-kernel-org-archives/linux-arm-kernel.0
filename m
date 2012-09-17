From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Mon, 17 Sep 2012 09:56:37 -0400
Subject: [PATCH v4 10/24] xen/arm: compile and run xenbus
In-Reply-To: <alpine.DEB.2.02.1209171205470.29232@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1209141145150.29232@kaball.uk.xensource.com>
 <1347621207-11294-10-git-send-email-stefano.stabellini@eu.citrix.com>
 <20120914130308.GI25249@phenom.dumpdata.com>
 <alpine.DEB.2.02.1209171205470.29232@kaball.uk.xensource.com>
Message-ID: <20120917135637.GG11553@phenom.dumpdata.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 12:05:59PM +0100, Stefano Stabellini wrote:
> On Fri, 14 Sep 2012, Konrad Rzeszutek Wilk wrote:
> > On Fri, Sep 14, 2012 at 12:13:12PM +0100, Stefano Stabellini wrote:
> > > bind_evtchn_to_irqhandler can legitimately return 0 (irq 0): it is not
> > > an error.
> > > 
> > > If Linux is running as an HVM domain and is running as Dom0, use
> > > xenstored_local_init to initialize the xenstore page and event channel.
> > 
> > Let me stick it in my tree and see how it works overnight with HVM and PV guests.
> 
> Did it work?

Yes!
