From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 17 Dec 2016 21:37:46 +0200
Subject: [PATCH] Documentation: dt: Explicitly mark Samsung Exynos SoC
 bindings as unstable
In-Reply-To: <1481897676-13578-1-git-send-email-m.szyprowski@samsung.com>
References: <1481897676-13578-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20161217193746.GA8980@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 16, 2016 at 03:14:36PM +0100, Marek Szyprowski wrote:
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

I agree but please re-send it after merge window. This is not the best
time to start discussions about it.

Best regards,
Krzysztof
