From: tj@kernel.org (Tejun Heo)
Date: Tue, 8 Jul 2014 09:42:03 -0400
Subject: [PATCH v9 3/7] ata: libahci: allow to use multiple PHYs
In-Reply-To: <1404728173-20263-4-git-send-email-antoine.tenart@free-electrons.com>
References: <1404728173-20263-1-git-send-email-antoine.tenart@free-electrons.com>
 <1404728173-20263-4-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20140708134203.GD4979@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One more thing.

On Mon, Jul 07, 2014 at 12:16:09PM +0200, Antoine T?nart wrote:
> This introduce a new way of defining SATA ports in the device tree, with
> one port per sub-node. This as the advantage of allowing a per port
> configuration. Because some ports may be accessible but disabled in the
> device tree, the default port_map is computed automatically when using
> this.

Any chance the old one phy config can be moved over to this scheme so
that we don't have to carry two separate mechanisms?

Thanks.

-- 
tejun
