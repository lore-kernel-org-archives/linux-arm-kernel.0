From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 9 Dec 2015 23:44:36 +0100
Subject: [PATCH 1/5] ARM: mediatek: Add MT2701 config options for mediatek
 SoCs.
In-Reply-To: <1448527472-20651-2-git-send-email-biao.huang@mediatek.com>
References: <1448527472-20651-1-git-send-email-biao.huang@mediatek.com>
 <1448527472-20651-2-git-send-email-biao.huang@mediatek.com>
Message-ID: <CACRpkdYdJmb5vLmDmaRGt=0PGs3GzyPnqtEh3UJQ5euoxyg6Fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2015 at 9:44 AM, Biao Huang <biao.huang@mediatek.com> wrote:

> From: Erin Lo <erin.lo@mediatek.com>
>
> The upcoming MTK pinctrl driver have a big pin table for each SoC
> and we don't want to bloat the kernel binary if we don't need it.
> Add config options so we can build for one SoC only. Add MT2701.
>
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>
FWIW, take this through the ARM SoC tree, since it's
just a Kconfig symbol, the pin control patches
should be possible to merge orthogonally.

Yours,
Linus Walleij
