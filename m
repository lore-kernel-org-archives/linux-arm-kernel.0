From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Sat, 19 Aug 2017 11:21:24 +0200
Subject: [PATCH v5 3/9] mfd: tmio: Add partition parsers platform data
In-Reply-To: <20170819092603.1c919b4b@bbrezillon>
References: <1502743720-28672-1-git-send-email-andrea.adami@gmail.com>
 <1502743720-28672-4-git-send-email-andrea.adami@gmail.com>
 <20170815065835.jcuweb377lqioddc@dell>
 <20170819092603.1c919b4b@bbrezillon>
Message-ID: <20170819112124.59854507@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Sat, 19 Aug 2017 09:26:03 +0200,
Boris Brezillon <boris.brezillon@free-electrons.com> a ?crit :

> Hi Lee,
> 
> Le Tue, 15 Aug 2017 07:58:35 +0100,
> Lee Jones <lee.jones@linaro.org> a ?crit :
> 
> > On Mon, 14 Aug 2017, Andrea Adami wrote:
> >   
> > > With the introduction of sharpslpart partition parser we can now read the
> > > offsets from NAND: we specify the list of the parsers as platform data, with
> > > cmdlinepart and ofpart parsers first allowing to override the part. table
> > > written in NAND. This is done in the board files using this driver.
> > > 
> > > Thus, we need to extend tmio_nand_data to consider the partition parsers.
> > > 
> > > Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
> > > ---
> > >  include/linux/mfd/tmio.h | 1 +
> > >  1 file changed, 1 insertion(+)    
> > 
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> >   
> 
> I'm about to apply patches 1 to 5 of this series to the nand/next

I meant patches 2 to 5, patch 1 still requires a few adjustments.

> branch. Do you want me to create an immutable branch with this patch?
> 
> Regards,
> 
> Boris
