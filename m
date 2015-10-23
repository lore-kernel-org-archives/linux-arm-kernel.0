From: kgene@kernel.org (Kukjin Kim)
Date: Sat, 24 Oct 2015 04:47:36 +0900
Subject: [PATCH v3 1/3] dt-bindings: Consolidate SRAM bindings from all
 vendors
In-Reply-To: <1445564361-16974-1-git-send-email-k.kozlowski@samsung.com>
References: <1445564361-16974-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <562A8ED8.6060904@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/23/15 10:39, Krzysztof Kozlowski wrote:
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
Applied with Heiko and Maxime's ack.

Thanks,
Kukjin
