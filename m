From: olof@lixom.net (Olof Johansson)
Date: Mon, 7 Mar 2011 15:48:45 -0800
Subject: [PATCH v2] ARM: tegra: seaboard: register i2c devices
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF045687B99F@HQMAIL01.nvidia.com>
References: <1299540862-3848-1-git-send-email-olof@lixom.net>
	<74CDBE0F657A3D45AFBB94109FB122FF045687B99F@HQMAIL01.nvidia.com>
Message-ID: <AANLkTinTg+E6grA_ns22gNHeYLCZ4G1BuGRwOJ002FBR@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 7, 2011 at 3:42 PM, Stephen Warren <swarren@nvidia.com> wrote:

>> @@ -166,6 +166,7 @@ static struct tegra_gpio_table gpio_table[] = {
>> ? ? ? { .gpio = TEGRA_GPIO_SD2_POWER, ? ? ? ? .enable = true },
>> ? ? ? { .gpio = TEGRA_GPIO_LIDSWITCH, ? ? ? ? .enable = true },
>> ? ? ? { .gpio = TEGRA_GPIO_POWERKEY, ? ? ? ? ?.enable = true },
>> + ? ? { .gpio = TEGRA_GPIO_ISL29018_IRQ, ? ? ?.enable = true },
>
> There's a space after "_IRQ," here. I think that's what's throwing off
> the display in my crappy email reader.
>
> Aside from that,

Ah, d'oh. thanks. Fixed up as I added your acked-by, I won't repost
just for that though.


-Olof
