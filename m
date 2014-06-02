From: olof@lixom.net (Olof Johansson)
Date: Mon, 2 Jun 2014 10:01:36 -0700
Subject: [PATCH 1/3] arm: multi_v7: enable igb, stmpe, spidev, lm95245,
 pwm leds
In-Reply-To: <cc612cd3f24f01cfc8fd3e81b1027ff94862e8b4.1401700579.git.marcel@ziswiler.com>
References: <cc612cd3f24f01cfc8fd3e81b1027ff94862e8b4.1401700579.git.marcel@ziswiler.com>
Message-ID: <CAOesGMg6aBpH18VO6XF1HxbXsJy92QadT3MVT2vOY41s=oCRrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 2, 2014 at 2:43 AM, Marcel Ziswiler <marcel@ziswiler.com> wrote:
> The NVIDIA Tegra 3 based Apalis T30 module contains an Intel i210 resp.
> i211 gigabit Ethernet controller, an STMPE811 ADC/touch controller,
> SPI bus and PWM LEDs generically accessible from user space and an
> LM95245 temperature sensor chip. The later four can also be found on
> the Colibri T30 module.
>
> While at it move the NEON entry down to its proper place to have it all
> nicely ordered again.
>
> Signed-off-by: Marcel Ziswiler <marcel@ziswiler.com>
> ---
> BTW: How about TEGRA_EMC_SCALING_ENABLE, MACH_UX500_DT, OMAP_USB3 and
> MMC_SUNXI which I haven't found any mentioning anywhere, MTD_M25P80
> which depends on MTD_SPI_NOR or DOVE_THERMAL which depends on the
> legacy ARCH_DOVE (besides USE_OF of course) being not much of multi
> compatible?

Can you resend towards the end of the merge window, please? We should
make a pass and update anything new that has been merged for 3.16
around then.


-Olof
