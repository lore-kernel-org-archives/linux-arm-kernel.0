From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 18 Sep 2018 12:58:40 -0700
Subject: [PATCH v2 16/22] pinctrl: mediatek: extend struct mtk_pin_desc
 which per-pin driver depends on
In-Reply-To: <8706de60fe75838b595d3be73681bbca344734a8.1536404280.git.sean.wang@mediatek.com>
References: <cover.1536404280.git.sean.wang@mediatek.com>
 <8706de60fe75838b595d3be73681bbca344734a8.1536404280.git.sean.wang@mediatek.com>
Message-ID: <CACRpkdY2YOu-BPt-qeZQt+o4TiT5UKrD8UfV_bOuJ822nAfohQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 8, 2018 at 4:08 AM <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> Because the pincrl-mtk-common.c is an implementation for per-pin binding,
> its pin descriptor includes more information than pinctrl-mtk-common-v2
> so far can support. So, we complement these data before writing a driver
> using pincrl-mtk-common-v2.c for per-pin binding. By the way, the size of
> struct mtk_pin_desc would be larger than struct pinctrl_pin_desc can hold,
> so it's necessary to have a copy before the pins information is being
> registered into the core.
>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied.

Yours,
Linus Walleij
