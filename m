From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Tue, 29 May 2018 09:06:42 +0200
Subject: [PATCH v2] Documentation: dt-bindings: Explicitly mark Samsung
 Exynos SoC bindings as unstable
In-Reply-To: <20180528191327.23772-1-krzk@kernel.org>
References: <20180528191327.23772-1-krzk@kernel.org>
Message-ID: <CABxcv=mMEa9Y77CvMsrLXGnfF60L84rthhrR3ZWEfeTSosw2Qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 28, 2018 at 9:13 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> From: Marek Szyprowski <m.szyprowski@samsung.com>
>
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
> bindings, make development of new platforms easier and allow to make
> cleanup of the existing code and device tree files, lets mark some
> Samsung Exynos SoC platform bindings as unstable. This means that
> bindings can may change at any time and users should use the dtb file
> compiled from the same kernel source tree as the kernel image.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
Javier
