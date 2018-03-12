From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 12 Mar 2018 18:59:12 +0100
Subject: [PATCH 4/9] ARM: dts: exynos: Fix "debounce-interval" property
 misspelling
In-Reply-To: <1518531335-5170-5-git-send-email-geert+renesas@glider.be>
References: <1518531335-5170-1-git-send-email-geert+renesas@glider.be>
 <1518531335-5170-5-git-send-email-geert+renesas@glider.be>
Message-ID: <20180312175912.7mm5fnrtgmnltd4b@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 13, 2018 at 03:15:30PM +0100, Geert Uytterhoeven wrote:
> "debounce-inteval" was never supported.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> ---
> Please apply to your tree when appropriate.
> 
>  arch/arm/boot/dts/exynos4412-trats2.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Oops, I am sorry, but that one slipped through my inbox and did not show
up in patchwork because of missing linux-samsung-soc Cc.

Anyway, I rebased it now (rename from trats2.dts -> midas.dtsi) and
applied.

Thanks!

Best regards,
Krzysztof
