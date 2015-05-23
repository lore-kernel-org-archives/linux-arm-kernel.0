From: kgene@kernel.org (Kukjin Kim)
Date: Sat, 23 May 2015 11:18:58 +0900
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Enable display on Trats2board
In-Reply-To: <555EF2B5.1000504@collabora.co.uk>
References: <1432255718-11695-1-git-send-email-k.kozlowski@samsung.com>
 <1432255718-11695-2-git-send-email-k.kozlowski@samsung.com>
 <555EF2B5.1000504@collabora.co.uk>
Message-ID: <555FE392.5030409@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/15 18:11, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 05/22/2015 02:48 AM, Krzysztof Kozlowski wrote:
>> Enable the Exynos DSI and S6E8AA0 panel for full X11 display on Trats2.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> ---
>>  arch/arm/configs/multi_v7_defconfig | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
>> index 0848337a2a01..e9785020aab1 100644
>> --- a/arch/arm/configs/multi_v7_defconfig
>> +++ b/arch/arm/configs/multi_v7_defconfig
>> @@ -413,10 +413,12 @@ CONFIG_DRM=y
>>  CONFIG_DRM_PTN3460=m
>>  CONFIG_DRM_PS8622=m
>>  CONFIG_DRM_EXYNOS=m
>> +CONFIG_DRM_EXYNOS_DSI=y
>>  CONFIG_DRM_EXYNOS_FIMD=y
>>  CONFIG_DRM_EXYNOS_HDMI=y
>>  CONFIG_DRM_RCAR_DU=m
>>  CONFIG_DRM_TEGRA=y
>> +CONFIG_DRM_PANEL_S6E8AA0=m
>>  CONFIG_DRM_PANEL_SIMPLE=y
>>  CONFIG_FB_ARMCLCD=y
>>  CONFIG_FB_WM8505=y
>>
> 
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> 
Looks good to me and this would be handled by arm-soc guys directly :-)

Acked-by: Kukjin Kim <kgene@kernel.org>

Thanks,
Kukjin
