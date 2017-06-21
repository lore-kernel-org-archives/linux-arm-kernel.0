From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 21 Jun 2017 12:45:22 +0200
Subject: [RFC PATCH v3 3/6] ARM/arm64: dts: enable wakeup for cros-ec-spi
 devices
In-Reply-To: <1498039313-24220-4-git-send-email-jeffy.chen@rock-chips.com>
References: <1498039313-24220-1-git-send-email-jeffy.chen@rock-chips.com>
 <1498039313-24220-4-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <CAJKOXPdL2CB9VWNo=it0dos-4hJYrgHUSZwcG1DS=9c+YxXzhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 12:01 PM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
> We used to enable wakeup for cros-ec-spi devices unconditionally.
> Now we are using the more generic wakeup-source property to enable it.

Using wakeup-source property is still enabling this unconditionally.
What  do you exactly mean here?

>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
>
> Changes in v3: None
>
>  arch/arm/boot/dts/exynos5420-peach-pit.dts      | 1 +
>  arch/arm/boot/dts/exynos5800-peach-pi.dts       | 1 +
>  arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi | 1 +
>  arch/arm/boot/dts/tegra124-nyan.dtsi            | 1 +
>  arch/arm/boot/dts/tegra124-venice2.dts          | 1 +
>  arch/arm64/boot/dts/nvidia/tegra132-norrin.dts  | 1 +
>  arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi    | 1 +
>  7 files changed, 7 insertions(+)

Please split it per arch (arm and arm64) and per machine. I'll take
exynos after splitting.

Best regards,
Krzysztof
