From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 26 Aug 2015 14:41:37 +0200
Subject: [PATCH v4] pinctrl: mediatek: Implement wake handler and suspend
 resume
In-Reply-To: <1439541486-22203-1-git-send-email-maoguang.meng@mediatek.com>
References: <1439541486-22203-1-git-send-email-maoguang.meng@mediatek.com>
Message-ID: <CACRpkdad3iQ89CtUyybAiz7pgNV8cuFKm=z93UAAhJXJJBt15Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 14, 2015 at 10:38 AM,  <maoguang.meng@mediatek.com> wrote:

> From: Maoguang Meng <maoguang.meng@mediatek.com>
>
> This patch implement irq_set_wake to get who is wakeup source and
> setup on suspend resume.
>
> Signed-off-by: Maoguang Meng <maoguang.meng@mediatek.com>
>
> ---
> changes since v3:
> -add a comment in mtk_eint_chip_read_mask.
> -delete ALIGN when allocate eint_offsets.ports.
> -fix unrelated change.

Patch applied with Daniel's, Yingjoe's and Hongzhu's tags.

Yours,
Linus Walleij
