From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 18 Sep 2018 12:43:17 -0700
Subject: [PATCH v2 03/22] pinctrl: mediatek: extend struct
 mtk_pin_field_calc to pinctrl-mtk-common-v2.c
In-Reply-To: <d43dc09d7ef45940ee14ecf546e939e39315a28f.1536404280.git.sean.wang@mediatek.com>
References: <cover.1536404280.git.sean.wang@mediatek.com>
 <d43dc09d7ef45940ee14ecf546e939e39315a28f.1536404280.git.sean.wang@mediatek.com>
Message-ID: <CACRpkdabZop+9L5Hq9pCrYmHXug_qpm6QZV99HdnBh_ecXLnVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 8, 2018 at 4:08 AM <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> This patch adds members sz_reg fixed in struct mtk_pin_field_calc
>
> - The 'fixed' is used to represent the consecutive pins share the same
> bits within the same register with the 1st pin so that it can largely
> reduce the entry size a bit.
>
> - The 'sz_reg' is used to indicate the range of bits we use in a register
>   that may vary by SoC
>
> The above changes make the code more generic and this is useful as there
> might be other existing or future chips all use the same logic to access
> their register set and then being a little more abstract could help in the
> long run.
>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied.

Yours,
Linus Walleij
