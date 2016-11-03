From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 3 Nov 2016 22:10:21 +0200
Subject: [PATCH v3 3/5] arm64: dts: exynos: Add dts files for Samsung
 Exynos5433 64bit SoC
In-Reply-To: <20161103194716.GC12945@kozik-lap>
References: <1478155149-28527-1-git-send-email-cw00.choi@samsung.com>
 <1478155149-28527-4-git-send-email-cw00.choi@samsung.com>
 <20161103194716.GC12945@kozik-lap>
Message-ID: <20161103201021.GA9379@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2016 at 09:47:16PM +0200, Krzysztof Kozlowski wrote:
> On Thu, Nov 03, 2016 at 03:39:07PM +0900, Chanwoo Choi wrote:
> > This patch adds new Exynos5433 dtsi to support 64-bit Exynos5433 SoC based on
> > Octa-core CPUs (quad Cortex-A57 and quad Cortex-A53). And Exynos5433 supports
> > PSCI (Power State Coordination Interface) v0.1.
> > 
> > This patch includes following Device Tree node to support Exynos5433 SoC:
> > 1. Octa cores for big.LITTLE architecture
> > - Cortex-A53 LITTLE Quad-core
> > - Cortex-A57 big Quad-core
> > - Support PSCI v0.1
> > 
> 
> Patch looks good to me. The GIC interrupt flags will have to be fixed
> someday (e.f. https://patchwork.kernel.org/patch/9336553/) but this may
> wait... It is violating the GIC since ancient times so I guess we can
> violate it some more till someone will be annoyed enough to fix it. :)

Thanks, applied.

Best regards,
Krzysztof
