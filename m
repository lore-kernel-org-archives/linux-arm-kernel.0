From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Apr 2017 11:20:02 +0200
Subject: [PATCH v6 3/4] ARM: mvebu: Enable SENSORS_PWM_FAN in defconfig
In-Reply-To: <20170414154056.32055-4-ralph.sennhauser@gmail.com>
References: <20170414154056.32055-1-ralph.sennhauser@gmail.com>
 <20170414154056.32055-4-ralph.sennhauser@gmail.com>
Message-ID: <CACRpkda6P026U4pBXPuEJ=cYu+Hz9N_-snXcOXr5c0Q9g4jBig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 14, 2017 at 5:40 PM, Ralph Sennhauser
<ralph.sennhauser@gmail.com> wrote:

> From: Andrew Lunn <andrew@lunn.ch>
>
> Now that the GPIO driver also supports PWM operation, enable the PWM
> framework and fan driver in mvebu_v7_defconfig.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> URL: https://patchwork.ozlabs.org/patch/427297/
> [Ralph Sennhauser: add fan driver to defconfig]
> Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
> Tested-by: Andrew Lunn <andrew@lunn.ch>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Please funnel this through ARM SoC.

Yours,
Linus Walleij
