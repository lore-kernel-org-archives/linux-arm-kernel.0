From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 4 Apr 2013 08:33:41 -0300
Subject: [PATCH 1/3] ARM: dts: imx28-evk: Use the standard gpio reset
 binding
In-Reply-To: <1365062329.4089.12.camel@pizza.hi.pengutronix.de>
References: <1365026474-3446-1-git-send-email-festevam@gmail.com>
 <1365062329.4089.12.camel@pizza.hi.pengutronix.de>
Message-ID: <CAOMZO5AtpT6nmnoFKQPCnp9sLnUnOC5AoEtg0+BmhQbBcp8hzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Thu, Apr 4, 2013 at 4:58 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Hi Fabio,
>
> Am Mittwoch, den 03.04.2013, 19:01 -0300 schrieb Fabio Estevam:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> Instead of using a custom binding for turning on a GPIO that activates the
>> panel, use the standard one.
>
> While this might fit well code wise, is a reset GPIO the right
> abstraction for those panel enable GPIOs?
>
> I guess the distinction between a GPIO that only holds the panel
> controller in reset and one that also enables power supplies internally
> can't be always made easily.

Would gpio-regulator binding fit better in the case a GPIO is needed
for activating the LCD backlight?

Regards,

Fabio Estevam
