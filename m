From: jg1.han@samsung.com (Jingoo Han)
Date: Thu, 20 Jun 2013 16:57:32 +0900
Subject: [PATCH V6 3/3] ARM: dts: Add pcie controller node for Samsung
 EXYNOS5440 SoC
In-Reply-To: <20130620094835.3f1f34c2@skate>
References: <00c201ce6d85$83b072a0$8b1157e0$@samsung.com>
 <20130620094835.3f1f34c2@skate>
Message-ID: <00c301ce6d8b$d198b210$74ca1630$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, June 20, 2013 4:49 PM, Thomas Petazzoni wrote:
> 
> Dear Jingoo Han,
> 
> On Thu, 20 Jun 2013 16:12:24 +0900, Jingoo Han wrote:
> 
> > -	pinctrl {
> > +	pin_ctrl: pinctrl {
> >  		compatible = "samsung,exynos5440-pinctrl";
> 
> I know I'm nitpicking, but isn't this change completely unrelated to
> PCIe support?

This change is related to PCIe support.
Without this, I cannot use gpio binding.

This change was guided by Thomas Abraham (Author of Samsung pinctrl).
Also, it was confirmed by Kukjin Kim (Maintainer of Samsung SoC).

Thank you for your caring. :)

Best regards,
Jingoo Han

> 
> Thomas
> --
> Thomas Petazzoni, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
