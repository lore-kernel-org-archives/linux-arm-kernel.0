From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Feb 2013 20:31:36 +0100
Subject: [PATCH] gpio: pxa: add irq base in platform data
In-Reply-To: <1361116930-31038-1-git-send-email-haojian.zhuang@linaro.org>
References: <1361116930-31038-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdYNk2Yf3FFzvJub4G-yzB8Lhb6epCb99oF=d7i35azdHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 17, 2013 at 5:02 PM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> Macro PXA_GPIO_TO_IRQ() & MMP_GPIO_TO_IRQ() is used in machine driver
> without DT. Although we're allocating irq descriptions dynamically,
> it may break machine drivers without DT. Append pdata->irq_base.
> If irq_base is valid, allocate irq descriptions from irq_base.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

I think this patch was also part of the other series so I've already
looked at it?

Yours,
Linus Walleij
