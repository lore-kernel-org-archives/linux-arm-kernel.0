From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 8 Mar 2017 08:58:57 +0200
Subject: [PATCH v5 2/5] arm: dts: Add the burst and esc clock frequency
 properties to DSI node
In-Reply-To: <1488948852-5380-3-git-send-email-hoegeun.kwon@samsung.com>
References: <1488948852-5380-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170308045502epcas1p26f050caaf6eeb79bc88afcb0e2eaeac2@epcas1p2.samsung.com>
 <1488948852-5380-3-git-send-email-hoegeun.kwon@samsung.com>
Message-ID: <20170308065857.fe26iwlu3r5cmesx@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 08, 2017 at 01:54:09PM +0900, Hoegeun Kwon wrote:
> Add the burst and esc clock frequency properties to the parent (DSI node).
> Currently the clock is parsed from the port node, while it should be
> taken from the dsi node.
> 
> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> Reviewed-by: Andi Shyti <andi.shyti@samsung.com>
> ---
>  arch/arm/boot/dts/exynos3250-rinato.dts | 2 ++
>  arch/arm/boot/dts/exynos4210-trats.dts  | 2 ++
>  arch/arm/boot/dts/exynos4412-trats2.dts | 2 ++
>  3 files changed, 6 insertions(+)
> 

Thanks, applied.

Best regards,
Krzysztof
