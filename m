From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 28 Oct 2016 16:34:24 +0300
Subject: [PATCH 1/3] ARM: dts: exynos: Document eMMC/SD/SDIO devices in
 Exynos5250 Snow board
In-Reply-To: <1477588303-13681-1-git-send-email-javier@osg.samsung.com>
References: <1477588303-13681-1-git-send-email-javier@osg.samsung.com>
Message-ID: <20161028133424.GA5646@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2016 at 02:11:41PM -0300, Javier Martinez Canillas wrote:
> There's a cognitive load to figure out which mmc device node corresponds
> to the eMMC flash, uSD card and WiFI SDIO module on the Snow boards.
> 
> So it's better to have comments in the DTS to make this more clear.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> 
>  arch/arm/boot/dts/exynos5250-snow-common.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)

Thanks, applied after squashing three into one. These are only comments,
so no impact on the code, and meaning/goal of them is exactly same.

Best regards,
Krzysztof
