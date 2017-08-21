From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 21 Aug 2017 08:27:03 +0100
Subject: [PATCH v5 3/9] mfd: tmio: Add partition parsers platform data
In-Reply-To: <20170819092603.1c919b4b@bbrezillon>
References: <1502743720-28672-1-git-send-email-andrea.adami@gmail.com>
 <1502743720-28672-4-git-send-email-andrea.adami@gmail.com>
 <20170815065835.jcuweb377lqioddc@dell>
 <20170819092603.1c919b4b@bbrezillon>
Message-ID: <20170821072703.nmzarvksj6l7omrg@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 19 Aug 2017, Boris Brezillon wrote:

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
> branch. Do you want me to create an immutable branch with this patch?

No, not for a single line change.  Git should figure that out.

Thanks for asking though.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
