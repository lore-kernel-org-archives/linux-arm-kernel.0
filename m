From: robh@kernel.org (Rob Herring)
Date: Wed, 31 May 2017 14:42:33 -0500
Subject: [PATCH v3 01/10] arm: sunxi: add support for R40 SoC
In-Reply-To: <20170527102308.1988-2-icenowy@aosc.io>
References: <20170527102308.1988-1-icenowy@aosc.io>
 <20170527102308.1988-2-icenowy@aosc.io>
Message-ID: <20170531194232.fhiz7z3iqhnkacev@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 27, 2017 at 06:22:59PM +0800, Icenowy Zheng wrote:
> Allwinner R40 is a new SoC, with Quad Core Cortex-A7 and peripherals
> like A20.
> 
> Add support for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v3:
> - Use V1.0 documents.
> 
>  Documentation/arm/sunxi/README                  | 6 ++++++
>  Documentation/devicetree/bindings/arm/sunxi.txt | 1 +
>  arch/arm/mach-sunxi/sunxi.c                     | 1 +
>  3 files changed, 8 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
