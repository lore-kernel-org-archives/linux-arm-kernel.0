From: kgene@kernel.org (Kukjin Kim)
Date: Sat, 23 May 2015 11:17:43 +0900
Subject: [PATCH 1/2] ARM: exynos_defconfig: Enable display on Trats2 board
In-Reply-To: <555EF265.30608@collabora.co.uk>
References: <1432255718-11695-1-git-send-email-k.kozlowski@samsung.com>
 <555EF265.30608@collabora.co.uk>
Message-ID: <555FE347.6060908@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/15 18:09, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
Hi,

> On 05/22/2015 02:48 AM, Krzysztof Kozlowski wrote:
>> Enable the Exynos DSI and S6E8AA0 panel for full X11 display on Trats2.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> ---
>>  arch/arm/configs/exynos_defconfig | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
>> index d034c96c039b..e7ccec487422 100644
>> --- a/arch/arm/configs/exynos_defconfig
>> +++ b/arch/arm/configs/exynos_defconfig
>> @@ -135,9 +135,11 @@ CONFIG_DRM_BRIDGE=y
>>  CONFIG_DRM_PTN3460=y
>>  CONFIG_DRM_PS8622=y
>>  CONFIG_DRM_EXYNOS=y
>> +CONFIG_DRM_EXYNOS_DSI=y
>>  CONFIG_DRM_EXYNOS_FIMD=y
>>  CONFIG_DRM_EXYNOS_DP=y
>>  CONFIG_DRM_PANEL=y
>> +CONFIG_DRM_PANEL_S6E8AA0=y
>>  CONFIG_DRM_PANEL_SIMPLE=y
>>  CONFIG_FB=y
>>  CONFIG_FB_MODE_HELPERS=y
>>
> 
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> 
Thanks, applied.

- Kukjin
