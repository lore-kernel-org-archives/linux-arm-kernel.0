From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 24 May 2018 09:37:48 +0200
Subject: [PATCH v1 2/7] pinctrl: mediatek: refactor EINT related code for
 all MediaTek pinctrl can fit
In-Reply-To: <7265772c758d4c56cabb95fda708550bc4d2fcb5.1526835466.git.sean.wang@mediatek.com>
References: <cover.1526835466.git.sean.wang@mediatek.com>
 <7265772c758d4c56cabb95fda708550bc4d2fcb5.1526835466.git.sean.wang@mediatek.com>
Message-ID: <CACRpkdatfPK8r-wttDJ=ty--2T7AiW8YiAu6kqKN6FQTf9R23w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 20, 2018 at 7:01 PM,  <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> This patch is in preparation for adding EINT support to MT7622 pinctrl,
> and the refactoring doesn't alter any existent logic.
>
> A reason we have to refactor EINT code pieces into a generic way is that
> currently, they're tightly coupled with a certain type of MediaTek pinctrl
> would cause a grown in a very bad way as there is different types of
> pinctrl devices getting to join.
>
> Therefore, it is an essential or urgent thing that EINT code pieces are
> refactored to eliminate any dependencies across GPIO and EINT as possible.
>
> Additional structure mtk_eint_[xt, hw, regs] are being introduced for
> indicating how maps being designed between GPIO and EINT hw number, how to
> set and get GPIO state for a certain EINT pin, what characteristic on a
> EINT device is present on various SoCs.
>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied.

Yours,
Linus Walleij
