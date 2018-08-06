From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 6 Aug 2018 12:34:02 +0200
Subject: [PATCH v2 5/9] dmaengine: ste_dma40: use
 dmaenginem_async_device_register to simplify the code
In-Reply-To: <20180806085231.4597-6-sjhuang@iluvatar.ai>
References: <20180806085231.4597-1-sjhuang@iluvatar.ai>
 <20180806085231.4597-6-sjhuang@iluvatar.ai>
Message-ID: <CACRpkdYhZ6WPwPPyZ13KFhcjbRArXsqxk4W-+e5CvpJ7gX7+uA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 6, 2018 at 10:53 AM Huang Shijie <sjhuang@iluvatar.ai> wrote:

> Use dmaenginem_async_device_register to simplify the code:
>         remove dma_async_device_unregister.
>         remove label unregister_slave, unregister_memcpy
>
> Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
