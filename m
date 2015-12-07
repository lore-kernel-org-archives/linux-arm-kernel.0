From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 7 Dec 2015 09:03:05 -0300
Subject: [PATCH] ARM: multi_v7_defconfig: Enable fan, sensors and audio
 for Odroid XU3
In-Reply-To: <1449449994-10110-1-git-send-email-k.kozlowski@samsung.com>
References: <1449449994-10110-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <56657579.6070103@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 12/06/2015 09:59 PM, Krzysztof Kozlowski wrote:
> For Odroid XU3-family enable the:
>  - PWM fan (to control the CPU fan using thermal subsystem),
>  - TI INA231 sensors (provide power measurements of big.LITTLE cores,
>    DRAM and GPU),
>  - Samsung sound (for Odroid XU3 and Snow as well).
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  arch/arm/configs/multi_v7_defconfig | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index f6a2557b55df..419f9413402c 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
