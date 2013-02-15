From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Feb 2013 20:12:03 +0000
Subject: randconfig errors
In-Reply-To: <20130215194548.GC2244@beef>
References: <511E6FA4.2000709@gmail.com>
 <c01a8ed845054b9d9cbddb341bac5f0e@DLEE74.ent.ti.com>
 <20130215194548.GC2244@beef>
Message-ID: <201302152012.04128.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 February 2013, Matt Porter wrote:
> I'd be happy to see at least the compat() patch be picked up. Chris had
> to drop the omap_hsmmc dt dmaengine patches until that one is merged. I'm
> not sure whose tree that one should go through at this point...perhaps
> via Chris' tree now?

It really should have been in the crypto tree before Mark's patches
to use them, but if Chris is still considering the the hsmmc dt
patches for 3.9, including them there is probably the best way forward.

I would expect him to say no them at this point though, and in that
case, I think it should be either the slave-dma tree or the arm-soc
tree.

	Arnd
