From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Apr 2017 11:19:32 +0200
Subject: [PATCH v6 2/4] ARM: dts: mvebu: Add PWM properties to .dtsi files
In-Reply-To: <20170414154056.32055-3-ralph.sennhauser@gmail.com>
References: <20170414154056.32055-1-ralph.sennhauser@gmail.com>
 <20170414154056.32055-3-ralph.sennhauser@gmail.com>
Message-ID: <CACRpkdZE0wnotF+OdAmutJcU9JSE_LxNd7Lz7yXqcn_bq5VqgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 14, 2017 at 5:40 PM, Ralph Sennhauser
<ralph.sennhauser@gmail.com> wrote:

> From: Andrew Lunn <andrew@lunn.ch>
>
> Add properties to the GPIO nodes to allow them to be also used as PWM
> lines.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> URL: https://patchwork.ozlabs.org/patch/427294/
> [Ralph Sennhauser: Add new compatible string marvell,armada-370-xp-gpio]
> Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
> Tested-by: Andrew Lunn <andrew@lunn.ch>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Please funnel this through ARM SoC.

Yours,
Linus Walleij
