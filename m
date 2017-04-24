From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Apr 2017 11:20:31 +0200
Subject: [PATCH v6 4/4] ARM: dts: armada-xp: Use pwm-fan rather than
 gpio-fan
In-Reply-To: <20170414154056.32055-5-ralph.sennhauser@gmail.com>
References: <20170414154056.32055-1-ralph.sennhauser@gmail.com>
 <20170414154056.32055-5-ralph.sennhauser@gmail.com>
Message-ID: <CACRpkdbVVf91NhbiaHxo6doUdGH6thVsjoUom4nYQRhj_qkz3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 14, 2017 at 5:40 PM, Ralph Sennhauser
<ralph.sennhauser@gmail.com> wrote:

> From: Andrew Lunn <andrew@lunn.ch>
>
> The mvebu GPIO driver can also perform PWM on some pins. Use the pwm-fan
> driver to control the fan of the WRT1900AC, giving us finer grained control
> over its speed and hence noise.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> URL: https://patchwork.ozlabs.org/patch/427291/
> [Ralph Sennhauser: drop flags paramter from pwms, no longer used]
> Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
> Tested-by: Andrew Lunn <andrew@lunn.ch>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Please funnel this through ARM SoC.

Yours,
Linus Walleij
