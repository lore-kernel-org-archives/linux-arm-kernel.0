From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 29 Oct 2013 09:00:50 -0700
Subject: [PATCH v7] pinctrl: imx27: imx27 pincontrol driver
In-Reply-To: <1383057139-25304-1-git-send-email-mpa@pengutronix.de>
References: <1382950843-26066-3-git-send-email-mpa@pengutronix.de>
 <1383057139-25304-1-git-send-email-mpa@pengutronix.de>
Message-ID: <CACRpkdYKgA5E4-APSTHsM=zVbb3X2R4v+V4EeK3+W1tKPR1FeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 7:32 AM, Markus Pargmann <mpa@pengutronix.de> wrote:

> imx27 pincontrol driver using the imx1 core driver. The DT bindings are
> similar to other imx pincontrol drivers.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> Hi,
>
> another binding documentation update. The MUX_ID components are described more
> detailed now.

Patch tentatively applied unless someone has very fundamental
issues with it, it stays in. I really want a full transfer of i.MX
pin controllers to the subsystem, using device tree so we can
get rid of the old i.MX cruft in arch/arm.

Yours,
Linus Walleij
