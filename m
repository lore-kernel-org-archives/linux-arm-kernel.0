From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Jun 2018 14:19:36 +0200
Subject: [PATCH 3/7] pinctrl: mt7622: fix that pinctrl_claim_hogs cannot
 work
In-Reply-To: <3b1fa378e0a83a5f39497fe8efaf4c992507ed5d.1529639050.git.sean.wang@mediatek.com>
References: <f222c9f488490bd86d35346e725491e1de306ace.1529639050.git.sean.wang@mediatek.com>
 <3b1fa378e0a83a5f39497fe8efaf4c992507ed5d.1529639050.git.sean.wang@mediatek.com>
Message-ID: <CACRpkdaM2ZK-rF1_DKyZLnmbxCp0i-Myvke6HSVeGymayhJ4qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2018 at 5:49 AM <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> To allow claiming hogs by pinctrl, we cannot enable pinctrl until all
> groups and functions are being added done. Also, it's necessary that
> the corresponding gpiochip is being added when the pinctrl device is
> enabled.
>
> Cc: stable at vger.kernel.org
> Fixes: d6ed93551320 ("pinctrl: mediatek: add pinctrl driver for MT7622 SoC")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied for fixes.

Yours,
Linus Walleij
