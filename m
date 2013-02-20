From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 20 Feb 2013 12:06:35 +0530
Subject: randconfig errors
In-Reply-To: <201302152012.04128.arnd@arndb.de>
References: <511E6FA4.2000709@gmail.com>
 <c01a8ed845054b9d9cbddb341bac5f0e@DLEE74.ent.ti.com>
 <20130215194548.GC2244@beef> <201302152012.04128.arnd@arndb.de>
Message-ID: <20130220063635.GE23302@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 15, 2013 at 08:12:03PM +0000, Arnd Bergmann wrote:
> On Friday 15 February 2013, Matt Porter wrote:
> > I'd be happy to see at least the compat() patch be picked up. Chris had
> > to drop the omap_hsmmc dt dmaengine patches until that one is merged. I'm
> > not sure whose tree that one should go through at this point...perhaps
> > via Chris' tree now?
> 
> It really should have been in the crypto tree before Mark's patches
> to use them, but if Chris is still considering the the hsmmc dt
> patches for 3.9, including them there is probably the best way forward.
> 
> I would expect him to say no them at this point though, and in that
> case, I think it should be either the slave-dma tree or the arm-soc
> tree.
Do you want me to add the compat() patch? I had acked it sometime back

I was hoping to send the PULL request in a day or two... Pls let me know...

--
~Vinod
