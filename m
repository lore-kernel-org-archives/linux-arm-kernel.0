From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Tue, 8 Jul 2014 19:05:33 +0200
Subject: [PATCH v9 3/7] ata: libahci: allow to use multiple PHYs
In-Reply-To: <20140708134203.GD4979@htj.dyndns.org>
References: <1404728173-20263-1-git-send-email-antoine.tenart@free-electrons.com>
 <1404728173-20263-4-git-send-email-antoine.tenart@free-electrons.com>
 <20140708134203.GD4979@htj.dyndns.org>
Message-ID: <20140708170533.GB16148@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 08, 2014 at 09:42:03AM -0400, Tejun Heo wrote:
> One more thing.
> 
> On Mon, Jul 07, 2014 at 12:16:09PM +0200, Antoine T?nart wrote:
> > This introduce a new way of defining SATA ports in the device tree, with
> > one port per sub-node. This as the advantage of allowing a per port
> > configuration. Because some ports may be accessible but disabled in the
> > device tree, the default port_map is computed automatically when using
> > this.
> 
> Any chance the old one phy config can be moved over to this scheme so
> that we don't have to carry two separate mechanisms?

That would break the DT ABI.


Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
