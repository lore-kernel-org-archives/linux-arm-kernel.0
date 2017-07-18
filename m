From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 18 Jul 2017 07:03:02 +0200
Subject: [PATCH v5 4/5] arm64: dts: exynos: Remove the OF graph from DSI
 node
In-Reply-To: <1488948852-5380-5-git-send-email-hoegeun.kwon@samsung.com>
References: <1488948852-5380-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170308045502epcas1p21a483d429e2169b322e40fd833c47f27@epcas1p2.samsung.com>
 <1488948852-5380-5-git-send-email-hoegeun.kwon@samsung.com>
Message-ID: <20170718050302.GA13779@kozik-book>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 08, 2017 at 01:54:11PM +0900, Hoegeun Kwon wrote:
> The OF graph is not needed because the panel is a child of dsi. Remove
> the ports node in DSI node.
> 
> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> Reviewed-by: Andi Shyti <andi.shyti@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 14 --------------
>  1 file changed, 14 deletions(-)
> 

Thanks, applied this and 5/5.

Best regards,
Krzysztof
