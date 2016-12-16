From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 16 Dec 2016 11:18:12 -0300
Subject: [PATCH] Documentation: dt: Explicitly mark Samsung Exynos SoC
 bindings as unstable
In-Reply-To: <1481897676-13578-1-git-send-email-m.szyprowski@samsung.com>
References: <1481897676-13578-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <136c527a-a491-8a45-9ae9-3a2adfc59ab4@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Marek,

On 12/16/2016 11:14 AM, Marek Szyprowski wrote:
> Samsung Exynos SoCs and boards related bindings evolved since the initial
> introduction, but initially the bindings were minimal and a bit incomplete
> (they never described all the hardware modules available in the SoCs).
> Since then some significant (not fully compatible) changes have been
> already committed a few times (like gpio replaced by pinctrl, display ddc,
> mfc reserved memory, some core clocks added to various hardware modules,
> added more required nodes).
> 
> On the other side there are no boards which have device tree embedded in
> the bootloader. Device tree blob is always compiled from the kernel tree
> and updated together with the kernel image.
> 
> Thus to avoid further adding a bunch of workarounds for old/missing
> bindings and allow to make cleanup of the existing code and device tree
> files, lets mark Samsung Exynos SoC platform bindings as unstable. This
> means that bindings can may change at any time and users should use the
> dtb file compiled from the same kernel source tree as the kernel image.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---

I completely agree with you on this.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
