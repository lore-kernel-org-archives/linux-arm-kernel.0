From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 11 May 2012 10:18:13 -0300
Subject: [PATCH 4/5] ARM: dts: imx51-babbage: enable audio support
In-Reply-To: <1336718568-26810-5-git-send-email-shawn.guo@linaro.org>
References: <1336718568-26810-1-git-send-email-shawn.guo@linaro.org>
 <1336718568-26810-5-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAOMZO5Azg9=wZvkut+2d6XtU4zdO6jRiTjxUP+ocmpJWmUSJVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn,

On 5/11/12, Shawn Guo <shawn.guo@linaro.org> wrote:
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/boot/dts/imx51-babbage.dts |   28 +++++++++++++++++++++++++++-
>  arch/arm/boot/dts/imx51.dtsi        |   33

Looking at the Freescale kernel I see some GPIOs that need to be
setup, such as audio oscillator enable pin (GPUO4_26), but I don't see
any audio related GPIO pin in your patch.

Will this be added later via pinctrl?

Regards,

Fabio Estevam
