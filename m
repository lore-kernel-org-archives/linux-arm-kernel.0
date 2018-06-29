From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Jun 2018 14:17:18 +0200
Subject: [PATCH 1/7] pinctrl: mt7622: fix error path on failing at groups
 building
In-Reply-To: <f222c9f488490bd86d35346e725491e1de306ace.1529639050.git.sean.wang@mediatek.com>
References: <f222c9f488490bd86d35346e725491e1de306ace.1529639050.git.sean.wang@mediatek.com>
Message-ID: <CACRpkdbZd_Dj78i9-f1dkNrL8EH6GPrS4TDJXViANn2=SQf8CA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2018 at 5:49 AM <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> It should be to return an error code when failing at groups building.
>
> Cc: stable at vger.kernel.org
> Fixes: d6ed93551320 ("pinctrl: mediatek: add pinctrl driver for MT7622 SoC")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied for fixes.

Yours,
Linus Walleij
