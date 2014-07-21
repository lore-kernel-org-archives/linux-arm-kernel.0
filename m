From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Mon, 21 Jul 2014 11:02:13 +0200
Subject: [PATCH v10 3/8] ata: libahci_platform: move port_map parameters
 into the AHCI structure
In-Reply-To: <20140718134730.GA13012@htj.dyndns.org>
References: <1405686607-8126-1-git-send-email-antoine.tenart@free-electrons.com>
 <1405686607-8126-4-git-send-email-antoine.tenart@free-electrons.com>
 <20140718134730.GA13012@htj.dyndns.org>
Message-ID: <20140721090213.GC32208@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 18, 2014 at 09:47:30AM -0400, Tejun Heo wrote:
> On Fri, Jul 18, 2014 at 02:30:02PM +0200, Antoine T?nart wrote:
> > @@ -321,6 +321,8 @@ struct ahci_host_priv {
> >  	u32			cap;		/* cap to use */
> >  	u32			cap2;		/* cap2 to use */
> >  	u32			port_map;	/* port map to use */
> > +	u32			force_port_map;	/* force port map */
> > +	u32			mask_port_map;	/* mask out particular bits */
> 
> So, ->flags and ->force/mask_port_map are the only input ones, right?
> Can we collect them to one spot and label them as such?

Yes. So you want a comment about this in the header?

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
