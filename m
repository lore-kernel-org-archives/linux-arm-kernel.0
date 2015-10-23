From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 23 Oct 2015 12:49:29 +0200
Subject: [PATCH v3 1/3] dt-bindings: Consolidate SRAM bindings from all
 vendors
In-Reply-To: <1445564361-16974-1-git-send-email-k.kozlowski@samsung.com>
References: <1445564361-16974-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1694120.gDU4knuKKT@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 23. Oktober 2015, 10:39:19 schrieb Krzysztof Kozlowski:
> SRAM bindings for various SoCs, using the mmio-sram genalloc
> API, are spread over different places - per SoC vendor. Since all of
> these are quite similar (they depend on mmio-sram) move them to a common
> place.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Kukjin Kim <kgene@kernel.org>
> Suggested-by: Rob Herring <robh+dt@kernel.org>
> 
> ---
> 
> Changes since v2:
> 1. Update paths to sram.txt.
> 
> Changes since v1:
> 1. New patch. Extended suggestion from Rob.
> ---

> .../bindings/{arm/rockchip/pmu-sram.txt => sram/rockchip-pmu-sram.txt} 
> .../bindings/{arm/rockchip/smp-sram.txt => sram/rockchip-smp-sram.txt} 

for the Rockchip parts
Acked-by: Heiko Stuebner <heiko@sntech.de>
