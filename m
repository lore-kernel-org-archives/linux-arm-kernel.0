From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 2 Jun 2015 11:08:43 +0200
Subject: [PATCH 2/2] pinctrl: mediatek: Fix pinctrl register irq fail bug.
In-Reply-To: <1432719835-18939-3-git-send-email-hongzhou.yang@mediatek.com>
References: <1432719835-18939-1-git-send-email-hongzhou.yang@mediatek.com>
 <1432719835-18939-3-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <CACRpkdbCSBZ9eokjdA+88Yg9A3-Hz1sH93nB1H2qgv7Q+pRS9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 27, 2015 at 11:43 AM, Hongzhou Yang
<hongzhou.yang@mediatek.com> wrote:

> Since mt6397 is no need to support interrupt controller,
> I judged "interrupt-controller" property to skip it last patch.
> But the if judgement should on the contrary, this is a bug.
>
> And find of_property_read_bool is better for this case.
> So using of_property_read_bool instead of of_find_property.
>
> Also fix bug of misuse pointer.
>
> Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>

Patch applied with Axel's review tag.

Yours,
Linus Walleij
