From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 9 Sep 2010 10:48:12 +0530
Subject: [PATCH 0/6] ARM: l2x0: kexex, cleanup and optimisation
In-Reply-To: <1283960984.10137.82.camel@e102109-lin.cambridge.arm.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02CD0D34AF@dbde02.ent.ti.com>
	<1283960984.10137.82.camel@e102109-lin.cambridge.arm.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD0D3669@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,
> -----Original Message-----
> From: Catalin Marinas [mailto:catalin.marinas at arm.com]
> Sent: Wednesday, September 08, 2010 9:20 PM
> To: Shilimkar, Santosh
> Cc: Linus Walleij; Russell King - ARM Linux; linux-arm-
> kernel at lists.infradead.org; tglx at linutronix.de; linux-
> omap at vger.kernel.org; per.xx.fransson at stericsson.com
> Subject: RE: [PATCH 0/6] ARM: l2x0: kexex, cleanup and optimisation
> 
> On Wed, 2010-09-08 at 16:46 +0100, Shilimkar, Santosh wrote:
> > Here is the updated branch including "Per Fransson" patch.
> > http://dev.omapzoom.org/?p=santosh/kernel-omap4-
> base.git;a=shortlog;h=refs/heads/l2x0-pull-rmk
> 
> It looks fine to me.
> 

Are you ok if " [PATCH 3/6] omap4: l2x0: Override the default l2x0_disable"
patch gets merged via Russell's tree?

http://dev.omapzoom.org/?p=santosh/kernel-omap4-base.git;a=blobdiff;f=arch/arm/mach-omap2/omap4-common.c;h=b557cc2c4b10e2ba4b6c4d6e3397611fb2de5952;hp=13dc9794dcc2ea68fe9115cff7be9cd8c074a484;hb=e1612fb084e78d5cba127f360803863e87a1e0cd;hpb=32ff2ccc0ca4d22c211fc5f5cc71b3d9a950c8c3

Regards,
Santosh
