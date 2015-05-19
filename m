From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 May 2015 11:13:21 +0200
Subject: [PATCH v2 03/11] pinctrl: mediatek: data struct optimize and
 remove unused member
In-Reply-To: <1432015882-8646-4-git-send-email-hongzhou.yang@mediatek.com>
References: <1432015882-8646-1-git-send-email-hongzhou.yang@mediatek.com>
 <1432015882-8646-4-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <CACRpkdaO6u8LuQHhbwoFZFusGPz4FgCC+KyWvet7qVGa6MoTNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 8:11 AM, Hongzhou Yang
<hongzhou.yang@mediatek.com> wrote:

> From: Yingjoe Chen <yingjoe.chen@mediatek.com>
>
> struct mtk_desc_pin.chip, mtk_pinctrl_devdata.invser_offset
> and mtk_pinctrl_devdata.chip_type are never used in code.
> Remove them.
>
> Some per-pin data are using int for pin number and offsets.
> Change to short and rearrange to reduce const data size.
>
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>

Applied this version instead.

Yours,
Linus Walleij
