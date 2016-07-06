From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 06 Jul 2016 08:17:12 +0200
Subject: [PATCH] memory: samsung: exynos-srom: fix wrong count of registers
In-Reply-To: <1467718817-19239-1-git-send-email-sw0312.kim@samsung.com>
References: <1467718817-19239-1-git-send-email-sw0312.kim@samsung.com>
Message-ID: <577CA268.5020606@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2016 01:40 PM, Seung-Woo Kim wrote:
> This patch fixes wrong count of array for srom registers from probe
> function.
> 
> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
> ---
>  drivers/memory/samsung/exynos-srom.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied.

Best regards,
Krzysztof
