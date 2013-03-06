From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Wed, 6 Mar 2013 16:21:14 -0300
Subject: [PATCH 1/5] ARM: sunxi: dt: Use clocks property instead of
 clock-frequency for the UARTs
In-Reply-To: <1362583767-13862-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1362583767-13862-1-git-send-email-maxime.ripard@free-electrons.com>
 <1362583767-13862-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <BLU0-SMTP2083B1177898DC8738745BC8AE40@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Maxime,

El 06/03/13 12:29, Maxime Ripard escribi?:
> Commit 0bbeb3c3 ("of serial port driver - add clk_get_rate() support") made
> possible to use directly a clock phandle instead of a raw frequency
> specified in the clock frequency attribute, so let's use it.

Aren't we using the 8250_dw driver since mainline's 1bea07f16d ("ARM:
sunxi: Use the Synosys APB UART instead of ns8250") though? That one
doesn't seem to have clock phandle support as of today.

I have two patches to add support to it and switch the UARTs to "clocks"
with a phandle as part of the clock gates series on my tree if you want
to have a look.

Emilio
