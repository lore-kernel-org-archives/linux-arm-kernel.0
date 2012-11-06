From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Tue, 6 Nov 2012 06:46:13 +0000
Subject: [PATCH 8/8] ARM: dts: AM33XX: Add PWM backlight DT data to
 am335x-evm
In-Reply-To: <1352106749-9437-9-git-send-email-avinashphilip@ti.com>
References: <1352106749-9437-1-git-send-email-avinashphilip@ti.com>
 <1352106749-9437-9-git-send-email-avinashphilip@ti.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EC04488@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2012 at 14:42:29, Philip, Avinash wrote:
[...]

> +	am33xx_pinmux: pinmux at 44e10800 {
> +		ecap0_pins: backlight_pins {
> +			pinctrl-single,pins = <
> +				0x164 0x0	/* eCAP0_in_PWM0_out.eCAP0_in_PWM0_out MODE0 */
> +			>;
> +		};
> +	};
> +
Ok I see the pinctrl entries here. Shouldn't this be done before
the change in the driver?

Regards.
Vaibhav
