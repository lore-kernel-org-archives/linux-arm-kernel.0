From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 20 Jun 2013 10:00:13 +0200
Subject: [PATCH V6 3/3] ARM: dts: Add pcie controller node for Samsung
 EXYNOS5440 SoC
In-Reply-To: <00c301ce6d8b$d198b210$74ca1630$@samsung.com>
References: <00c201ce6d85$83b072a0$8b1157e0$@samsung.com>
 <20130620094835.3f1f34c2@skate>
 <00c301ce6d8b$d198b210$74ca1630$@samsung.com>
Message-ID: <20130620100013.6000458f@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jingoo Han,

On Thu, 20 Jun 2013 16:57:32 +0900, Jingoo Han wrote:

> > > -	pinctrl {
> > > +	pin_ctrl: pinctrl {
> > >  		compatible = "samsung,exynos5440-pinctrl";
> > 
> > I know I'm nitpicking, but isn't this change completely unrelated to
> > PCIe support?
> 
> This change is related to PCIe support.
> Without this, I cannot use gpio binding.
> 
> This change was guided by Thomas Abraham (Author of Samsung pinctrl).
> Also, it was confirmed by Kukjin Kim (Maintainer of Samsung SoC).
> 
> Thank you for your caring. :)

I mean, the change is fine for sure, but it should maybe part of a
separate patch as it is more a fix than really the introduction of the
PCIe controller node, as the patch title suggests. This would also for
example allow this fix to be merged right now (for 3.11), regardless of
what happens for the rest of your PCIe patches.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
