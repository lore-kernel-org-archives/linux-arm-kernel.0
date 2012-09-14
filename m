From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 14 Sep 2012 16:30:15 +0800
Subject: [PATCH v2 06/11] USB: mxs-phy: add basic otg support
In-Reply-To: <20120912103901.GA6614@as23.pp.htv.fi>
References: <1346137397-32374-1-git-send-email-richard.zhao@freescale.com>
 <1346137397-32374-7-git-send-email-richard.zhao@freescale.com>
 <20120912103901.GA6614@as23.pp.htv.fi>
Message-ID: <20120914083014.GC7167@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2012 at 01:39:01PM +0300, Heikki Krogerus wrote:
> Hi,
> 
> On Tue, Aug 28, 2012 at 03:03:12PM +0800, Richard Zhao wrote:
> > +static int mxs_phy_set_host(struct usb_otg *otg, struct usb_bus *host)
> > +{
> 
> Shouldn't you at least save the host pointer?
> 
> otg->host = host;
It looks making sense, though it's not called by chipidea driver.

> 
> > +	return 0;
> > +}
> > +
> > +static int mxs_phy_set_peripheral(struct usb_otg *otg,
> > +					struct usb_gadget *gadget)
> > +{
> 
> And the same with the gadget?

Thanks
Richard
> 
> > +	return 0;
> > +}
> 
> -- 
> heikki
> 
