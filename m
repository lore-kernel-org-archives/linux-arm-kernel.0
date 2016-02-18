From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 19 Feb 2016 00:31:03 +0100
Subject: [PATCH 2/2] pinctrl: mediatek: add input-enable and direction
 setting for eint resources
In-Reply-To: <1455650194-9813-3-git-send-email-biao.huang@mediatek.com>
References: <1455650194-9813-1-git-send-email-biao.huang@mediatek.com>
 <1455650194-9813-3-git-send-email-biao.huang@mediatek.com>
Message-ID: <CACRpkdYeyAejh5Dtw7SKb7o790PcQgnz4tWpT+79hQ2_H6Lj5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 8:16 PM, Biao Huang <biao.huang@mediatek.com> wrote:

> To use pin as eint, user should make sure that:
> 1. pin is set to right mode, this is done in .irq_request_resources
> implementation already.
> 2. direction of the pin is input, which should call GPIO API to set
> pin to input gpio.
> We add what step 2 do to .irq_request_resources so that user doesn't
> need call GPIO API any more when pin for eint usage.
>
> Signed-off-by: Biao Huang <biao.huang@mediatek.com>

Patch applied.

Yours,
Linus Walleij
