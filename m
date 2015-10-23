From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 23 Oct 2015 08:06:26 +0200
Subject: [PATCH v3 1/3] dt-bindings: Consolidate SRAM bindings from all
 vendors
In-Reply-To: <1445564361-16974-1-git-send-email-k.kozlowski@samsung.com>
References: <1445564361-16974-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20151023060626.GF10947@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2015 at 10:39:19AM +0900, Krzysztof Kozlowski wrote:
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

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151023/126dbb3b/attachment.sig>
