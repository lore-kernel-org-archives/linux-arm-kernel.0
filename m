From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 5 Feb 2016 14:58:28 +0100
Subject: [PATCH 2/2] pinctrl: mediatek: Add gpio_request_enable support
In-Reply-To: <1454462686-770-3-git-send-email-biao.huang@mediatek.com>
References: <1454462686-770-1-git-send-email-biao.huang@mediatek.com>
 <1454462686-770-3-git-send-email-biao.huang@mediatek.com>
Message-ID: <CACRpkdZPTOPfsqx34yr9-bSyg4-N_dR+beqAXjJc1NjK2xh4Jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 3, 2016 at 2:24 AM, Biao Huang <biao.huang@mediatek.com> wrote:

> Implement the .gpio_request_enable() callbacks in struct pinmux_ops
> in mediatek pinctrl driver. Make sure that when gpio_request is called,
> GPIO on the pin is enabled.
>
> Signed-off-by: Biao Huang <biao.huang@mediatek.com>

Patch applied to my devel-mt2701 branch.

Yours,
Linus Walleij
