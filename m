From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Thu, 9 Feb 2012 11:25:48 +0000
Subject: [RFC PATCH 3/8] misc: emif: add register definitions for EMIF
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC1317897B8@DBDE01.ent.ti.com>
References: <331ABD5ECB02734CA317220B2BBEABC1317897B8@DBDE01.ent.ti.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433179B3F3@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of V, Aneesh
> Sent: Saturday, February 04, 2012 5:46 PM
> To: linux-omap at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org; akpm at linux-foundation.org; V, Aneesh
> Subject: [RFC PATCH 3/8] misc: emif: add register definitions for EMIF
> 

Sorry for the delayed response. Can these register definitions be put in a place
where the code from the arch/arm/mach-omap2/* can also access it?

Devices like AM335x and TI814x will need to reconfigure the EMIF when coming out
of low power states and putting these register definitions in a common place
will help us avoid some code duplication.

Regards,
Vaibhav
