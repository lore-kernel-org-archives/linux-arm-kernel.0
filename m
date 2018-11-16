From: horms@verge.net.au (Simon Horman)
Date: Fri, 16 Nov 2018 06:47:24 -0800
Subject: [PATCH v2 1/2] arm64: renesas: Move SoC Kconfig symbols to
 drivers/soc/renesas/
In-Reply-To: <20181116134842.26488-2-geert+renesas@glider.be>
References: <20181116134842.26488-1-geert+renesas@glider.be>
 <20181116134842.26488-2-geert+renesas@glider.be>
Message-ID: <20181116144723.tpbquqzazfqtkm2d@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2018 at 02:48:41PM +0100, Geert Uytterhoeven wrote:
> arch/arm64/Kconfig.platforms has SoC-specific Kconfig symbols for
> Renesas SoCs, while other vendors have only a single Kconfig symbol.
> 
> Increase consistency with other vendors by moving the SoC-specific
> Kconfig symbols to drivers/soc/renesas/Kconfig.
> 
> Increase consistency with R-Car Gen1 and Gen2 SoCs on arm32 by
> introducing a family-specific Kconfig symbol for R-Car Gen3
> (ARCH_RCAR_GEN3), which enables family-specific hardware features.
> While so far only a single family (R-Car Gen3 and derivatives) of
> Renesas arm64 SoCs is supported by Linux, this will make it easier
> to add support for other SoC families later.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Introduce a family-specific Kconfig symbol for R-Car Gen3.

Thanks Geert,

applied for v4.21.
