From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 19 Oct 2015 09:11:29 +0900
Subject: [PATCH v2 4/6] ARM: dts: Remove broken-cd from eMMC node in
 exynos5800-peach-pi
In-Reply-To: <1444927873-15140-5-git-send-email-javier@osg.samsung.com>
References: <1444927873-15140-1-git-send-email-javier@osg.samsung.com>
 <1444927873-15140-5-git-send-email-javier@osg.samsung.com>
Message-ID: <56243531.2090307@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.10.2015 01:51, Javier Martinez Canillas wrote:
> The eMMC is non-removable so is marked with the non-removable DT
> property to avoid having to redetect it after a suspend/resume.
> 
> But it also has the broken-cd property which is wrong since only
> one of the DT properties for card detection should be used.
> 
> Also remove the card-detect-delay property that is not needed with
> non-removable.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> 
> Changes since v1:
> - None, new patch.
> 
>  arch/arm/boot/dts/exynos5800-peach-pi.dts | 2 --
>  1 file changed, 2 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
