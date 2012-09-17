From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Mon, 17 Sep 2012 10:06:53 -0400
Subject: [PATCH v4 10/24] xen/arm: compile and run xenbus
In-Reply-To: <alpine.DEB.2.02.1209171444060.29232@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1209141145150.29232@kaball.uk.xensource.com>
 <1347621207-11294-10-git-send-email-stefano.stabellini@eu.citrix.com>
 <20120917132932.GA11517@phenom.dumpdata.com>
 <alpine.DEB.2.02.1209171444060.29232@kaball.uk.xensource.com>
Message-ID: <20120917140653.GB11996@phenom.dumpdata.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 02:45:00PM +0100, Stefano Stabellini wrote:
> On Mon, 17 Sep 2012, Konrad Rzeszutek Wilk wrote:
> > On Fri, Sep 14, 2012 at 12:13:12PM +0100, Stefano Stabellini wrote:
> > > bind_evtchn_to_irqhandler can legitimately return 0 (irq 0): it is not
> > > an error.
> > > 
> > > If Linux is running as an HVM domain and is running as Dom0, use
> > > xenstored_local_init to initialize the xenstore page and event channel.
> > > 
> > > 
> > > Changes in v4:
> > > 
> > > - do not xs_reset_watches on dom0.
> > > 
> > > 
> > > Changes in v2:
> > > 
> > > - refactor xenbus_init.
> > > 
> > > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > 
> > Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > 
> > 
> > If you would like I can also carry this in my tree.
> 
> OK, let's do that. I'll rebase again on your tree with this patch.

Done.
