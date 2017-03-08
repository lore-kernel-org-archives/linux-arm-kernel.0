From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 8 Mar 2017 08:58:39 +0200
Subject: [PATCH v5 1/5] arm64: dts: exynos: Add the burst and esc clock
 frequency properties to DSI node
In-Reply-To: <1488948852-5380-2-git-send-email-hoegeun.kwon@samsung.com>
References: <1488948852-5380-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170308045502epcas1p2b16df118e0ad91dbd2446687dc5ee843@epcas1p2.samsung.com>
 <1488948852-5380-2-git-send-email-hoegeun.kwon@samsung.com>
Message-ID: <20170308065839.cu4w6hextqa5m7qq@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 08, 2017 at 01:54:08PM +0900, Hoegeun Kwon wrote:
> Add the burst and esc clock frequency properties to the parent (DSI node).
> Currently the clock is parsed from the port node, while it should be
> taken from the dsi node.
> 
> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> Reviewed-by: Andi Shyti <andi.shyti@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 

Thanks, applied.

I'll prepare tags with these.

Best regards,
Krzysztof
