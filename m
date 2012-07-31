From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 31 Jul 2012 09:02:04 -0300
Subject: [PATCH 2/4] ARM: dts: mxs: Add alternative I2C muxing options for
 imx28
In-Reply-To: <1343730576-20494-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1343730576-20494-1-git-send-email-maxime.ripard@free-electrons.com>
 <1343730576-20494-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAOMZO5AaLB5m7TYPC03wTSFTDUTFrtV4Xr6gHrvKuGnpyUsf8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2012 at 7:29 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> +                               i2c0_pins_b: i2c0 at 1 {
> +                                       reg = <1>;
> +                                       fsl,pinmux-ids = <0x3001 0x3011>;

Can you please also list the name of the pin as comment (just like you
did for pwm4)?

This would allow us to quickly identify the muxing option without the
need of looking at the mxs pinctrl doc.

Regards,

Fabio Estevam
