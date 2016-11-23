From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 23 Nov 2016 19:19:22 +0200
Subject: [PATCH 2/4] ARM: dts: exynos: specify snps,dwmac in compatible
 string for gmac
In-Reply-To: <1479911091-19812-1-git-send-email-niklass@axis.com>
References: <1479911091-19812-1-git-send-email-niklass@axis.com>
Message-ID: <20161123171922.GA4408@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2016 at 03:24:51PM +0100, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@axis.com>
> 
> devicetree binding for stmmac states:
> - compatible: Should be "snps,dwmac-<ip_version>", "snps,dwmac"
> 	For backwards compatibility: "st,spear600-gmac" is also supported.
> 
> No functional change intended.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
>  arch/arm/boot/dts/exynos5440.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Thanks, applied.

Best regards,
Krzysztof
