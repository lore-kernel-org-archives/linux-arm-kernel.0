From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 24 Sep 2014 01:29:09 +0900
Subject: [PATCH v2] ARM: dts: Add Maxim 77693 PMIC to the Trats2 board
In-Reply-To: <1410793564-30445-1-git-send-email-k.kozlowski@samsung.com>
References: <1410793564-30445-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <54219FD5.4030601@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/16/14 00:06, Krzysztof Kozlowski wrote:
> The MAX77693 is a companion power management IC for smart phones and tablets.
>
> The MAX77693 contains input over-voltage protection (OVP),
> a fully-integrated 2.5A switching charger for Lithium Ion battery with
> integrated battery disconnect, OTG/accessory 5V output power,
> a high-current white LED driver for camera flash, two safeout LDOs,
> a haptic motor driver, Model Gauge m3 battery fuel gauge and MicroUSB
> Interface Controller (MUIC). I2C serial interface is used for
> communicating.
>
> Add MAX77693 node to the Trats2 board. This allows using:
>   - charger regulator,
>   - 2 safeout LDO regulators (for USB OTG),
>   - extcon.
>
> Signed-off-by: Krzysztof Kozlowski<k.kozlowski@samsung.com>
> Reviewed-by: Javier Martinez Canillas<javier.martinez@collabora.co.uk>
>
> ---
>
> Changes since v1:
> ==================
> 1. Use GPIO_ACTIVE_HIGH for gpio flags (suggested by Javier Martinez
>     Canillas).
> 2. Use regulator node name instead of deprecated regulator-compatible
>     property (suggested by Javier Martinez Canillas).
> 3. Add Javier Martinez Canillas' reviewed-by tag.
> ---
>   arch/arm/boot/dts/exynos4412-trats2.dts | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
>

Looks good to me, applied.

Thanks,
Kukjin
