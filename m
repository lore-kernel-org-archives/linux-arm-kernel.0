From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 22 Mar 2017 12:34:45 +0800
Subject: [RESEND PATCH v4 2/9] iio: adc: add support for X-Powers AXP20X
 and AXP22X PMICs ADCs
In-Reply-To: <20170320081653.8884-3-quentin.schulz@free-electrons.com>
References: <20170320081653.8884-1-quentin.schulz@free-electrons.com>
 <20170320081653.8884-3-quentin.schulz@free-electrons.com>
Message-ID: <CAGb2v66JC65=9WiMy-Nu+9tTFRLsJL2Eyb0wfJV_K=65ABc6Zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Mar 20, 2017 at 4:16 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> The X-Powers AXP20X and AXP22X PMICs have multiple ADCs. They expose the
> battery voltage, battery charge and discharge currents, AC-in and VBUS
> voltages and currents, 2 GPIOs muxable in ADC mode and PMIC temperature.
>
> This adds support for most of AXP20X and AXP22X ADCs.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> Reviewed-by: Jonathan Cameron <jic23@kernel.org>

This patch seems to depend on commit 4707274714ef ("mfd: axp20x: Correct name
of temperature data ADC registers") currently in the mfd tree.

Jonathan, would it be ok for Lee to take this patch through the mfd tree
as well?


Thanks
ChenYu

P.S. I'm thinking about having MFD_AXP20X imply its various sub-drivers.
Not sure if that was the intended usage of the new imply syntax though.
