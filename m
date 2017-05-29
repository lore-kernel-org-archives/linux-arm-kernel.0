From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 29 May 2017 18:33:13 +0200
Subject: [PATCH v3 02/10] pinctrl: sunxi: Add SoC ID definitions for A10,
 A20 and R40 SoCs
In-Reply-To: <20170527102308.1988-3-icenowy@aosc.io>
References: <20170527102308.1988-1-icenowy@aosc.io>
 <20170527102308.1988-3-icenowy@aosc.io>
Message-ID: <CACRpkdbPcAELAySk77xofYNVqach+0-2oJ1qMcGK5X1zA8gdeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 27, 2017 at 12:23 PM, Icenowy Zheng <icenowy@aosc.io> wrote:

> Allwinner A10, A20 and R40 SoCs have similar GPIO layout.
>
> Add SoC definitions in pinctrl-sunxi.h, in order to merge A20 support
> into A10 driver, and add R40 support into it.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v3:
> - Commit message change.

Patch applied with Chen-Yu's review tag.

Yours,
Linus Walleij
