From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Tue, 29 Jul 2014 09:14:47 +0200
Subject: [PATCH v11 4/8] ata: libahci: allow to use multiple PHYs
In-Reply-To: <20140728172724.GA7462@htj.dyndns.org>
References: <1406193450-17283-1-git-send-email-antoine.tenart@free-electrons.com>
 <1406193450-17283-5-git-send-email-antoine.tenart@free-electrons.com>
 <53D62624.6070502@redhat.com>
 <20140728172724.GA7462@htj.dyndns.org>
Message-ID: <20140729071447.GA9410@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 28, 2014 at 01:27:24PM -0400, Tejun Heo wrote:
> On Mon, Jul 28, 2014 at 12:29:56PM +0200, Hans de Goede wrote:
> ...
> > > +		if (!enabled_ports) {
> > > +			dev_warn(dev, "No port enabled\n");
> > > +			return ERR_PTR(-ENODEV);
> > 
> > This should be:
> > 			rc = -ENODEV;
> > 			goto err_out;
> > 
> > Sorry for not catching that sooner.
> > 
> > Other then that the entire series looks good and is:
> > 
> > Acked-by: Hans de Goede <hdegoede@redhat.com>
> 
> Antoine, can you please post an updated version of this patch?  No
> need to repost the whole series.  Also, how should the series be
> routed?

Sure, I'm doing this right away. Regarding the series, Kishon already
took patches 1-2.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
