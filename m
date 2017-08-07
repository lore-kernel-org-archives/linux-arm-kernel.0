From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Aug 2017 15:09:31 +0200
Subject: [PATCH] pinctrl: sunxi: fix V3s pinctrl driver IRQ bank base
In-Reply-To: <20170801145416.61854-1-icenowy@aosc.io>
References: <20170801145416.61854-1-icenowy@aosc.io>
Message-ID: <CACRpkdYJX6SX5NjLMopoD7nKkmhseBMMTei-FoxzXwRnNDUaFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 1, 2017 at 4:54 PM, Icenowy Zheng <icenowy@aosc.io> wrote:

> The V3s pin controller doesn't have the bank 0 (starts at address
> 0x200), which is like A33. However, this is not workarounded when
> developing the driver, which makes IRQ not working.
>
> Fix the IRQ bank base.
>
> Fixes: 56d9e4a76039 ("pinctrl: sunxi: add driver for V3s SoC")
> Cc: stable at vger.kernel.org

This patch only applies on the devel branch so I don't see why it is tagged
for stable.

> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Patch applied.

Yours,
Linus Walleij
