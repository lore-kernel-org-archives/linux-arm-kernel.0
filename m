From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 15 Oct 2018 16:18:00 +0200
Subject: [PATCH 4/5] pinctrl: mediatek: pinctrl-mtk-common-v2: Make eint_m
 u16
In-Reply-To: <20181008191411.32555-5-manivannan.sadhasivam@linaro.org>
References: <20181008191411.32555-1-manivannan.sadhasivam@linaro.org>
 <20181008191411.32555-5-manivannan.sadhasivam@linaro.org>
Message-ID: <CACRpkdZAem09Qb_bUBk+QA5ngdjGTxqLxTtMMsSnO7rTME1Njw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 8, 2018 at 9:14 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> For SoC's which lacks EINT support, U16_MAX is assigned to both eint_m
> and eint_n through macro NO_EINT_SUPPORT. This will generate integer
> overflow warning because eint_m is declared as u8 type. Hence modify
> the eint_m type to u16.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Patch applied with Matthias' review tag, thanks!

Yours,
Linus Walleij
