From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 15 May 2017 18:48:29 +0200
Subject: [PATCH v5 4/5] arm64: dts: exynos: Remove the OF graph from DSI
 node
In-Reply-To: <1488948852-5380-5-git-send-email-hoegeun.kwon@samsung.com>
References: <1488948852-5380-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170308045502epcas1p21a483d429e2169b322e40fd833c47f27@epcas1p2.samsung.com>
 <1488948852-5380-5-git-send-email-hoegeun.kwon@samsung.com>
Message-ID: <20170515164829.rfcqj5quw2jooh6u@kozik-lap>
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

Hi,

I wanted to apply this (and 5/5) but it seems that DRM change is not
merged. Was it included in v4.12-rc1?

Best regards,
Krzysztof
