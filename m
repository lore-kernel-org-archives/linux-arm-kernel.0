From: tj@kernel.org (Tejun Heo)
Date: Mon, 28 Jul 2014 13:27:24 -0400
Subject: [PATCH v11 4/8] ata: libahci: allow to use multiple PHYs
In-Reply-To: <53D62624.6070502@redhat.com>
References: <1406193450-17283-1-git-send-email-antoine.tenart@free-electrons.com>
 <1406193450-17283-5-git-send-email-antoine.tenart@free-electrons.com>
 <53D62624.6070502@redhat.com>
Message-ID: <20140728172724.GA7462@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 28, 2014 at 12:29:56PM +0200, Hans de Goede wrote:
...
> > +		if (!enabled_ports) {
> > +			dev_warn(dev, "No port enabled\n");
> > +			return ERR_PTR(-ENODEV);
> 
> This should be:
> 			rc = -ENODEV;
> 			goto err_out;
> 
> Sorry for not catching that sooner.
> 
> Other then that the entire series looks good and is:
> 
> Acked-by: Hans de Goede <hdegoede@redhat.com>

Antoine, can you please post an updated version of this patch?  No
need to repost the whole series.  Also, how should the series be
routed?

Thanks.

-- 
tejun
