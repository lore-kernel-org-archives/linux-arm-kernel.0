From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 20 Jun 2013 09:48:35 +0200
Subject: [PATCH V6 3/3] ARM: dts: Add pcie controller node for Samsung
 EXYNOS5440 SoC
In-Reply-To: <00c201ce6d85$83b072a0$8b1157e0$@samsung.com>
References: <00c201ce6d85$83b072a0$8b1157e0$@samsung.com>
Message-ID: <20130620094835.3f1f34c2@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jingoo Han,

On Thu, 20 Jun 2013 16:12:24 +0900, Jingoo Han wrote:

> -	pinctrl {
> +	pin_ctrl: pinctrl {
>  		compatible = "samsung,exynos5440-pinctrl";

I know I'm nitpicking, but isn't this change completely unrelated to
PCIe support?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
