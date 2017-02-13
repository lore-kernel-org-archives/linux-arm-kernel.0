From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 13 Feb 2017 15:52:01 +0100
Subject: [PATCH 3/8] pinctrl: sunxi: Add A64 R_PIO controller support
In-Reply-To: <20170208100009.29362-3-icenowy@aosc.xyz>
References: <20170208100009.29362-1-icenowy@aosc.xyz>
 <20170208100009.29362-3-icenowy@aosc.xyz>
Message-ID: <CACRpkdYzT3jZceSZv=iyd4hvTowOxzQrOZpEaS16m9Cm-d8mZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 8, 2017 at 11:00 AM, Icenowy Zheng <icenowy@aosc.xyz> wrote:

> The A64 has a R_PIO pin controller, similar to the one found on the H3 SoC.
> Add support for the pins controlled by the R_PIO controller.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

I'd be happy to merge patches 1,2 & 3 to the pinctrl tree but I need
a maintainer ACK on these three patches first.

Yours,
Linus Walleij
