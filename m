From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Dec 2017 13:15:56 +0100
Subject: [PATCH 3/4] ARM: dts: vf610-zii-dev-rev-b: add PHYs for switch2
In-Reply-To: <E1eRnWl-0006VL-TL@rmk-PC.armlinux.org.uk>
References: <20171220231108.GJ10595@n2100.armlinux.org.uk>
 <E1eRnWl-0006VL-TL@rmk-PC.armlinux.org.uk>
Message-ID: <CACRpkdaGQmY63zd+Zivp=v-OhN4tuWX7Z+vfDb9QxSqMQyAN3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 21, 2017 at 12:11 AM, Russell King
<rmk+kernel@armlinux.org.uk> wrote:

> Switch 2 has an 88e1545 PHY behind it, which is a quad PHY.  Only the
> first three PHYs are used, the remaining PHY is unused.  When we wire
> up the SFF sockets in a later commit, the omission of this causes the
> fourth PHY to be used for port 3.  Specifying the PHYs in DT avoids
> the auto-probing of the bus, and discovery of this PHY.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Ah this is elegant and what Andrew requested me to do for
another switch as well. Makes perfect sense. FWIW:

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
