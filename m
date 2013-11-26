From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 26 Nov 2013 09:54:10 +0100
Subject: [PATCH 4/6] arm: sa1100: h3600: refactor IrDA GPIO handling
In-Reply-To: <1385048414-9812-5-git-send-email-dbaryshkov@gmail.com>
References: <1385048414-9812-1-git-send-email-dbaryshkov@gmail.com>
 <1385048414-9812-5-git-send-email-dbaryshkov@gmail.com>
Message-ID: <CACRpkdZ45wsPv_sOjGj78jXmNt1tZc4mXUqPjOtm6qsWstv=Fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 21, 2013 at 4:40 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:

> Use gpio_request_array/gpio_free_array to request all GPIOs at once.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
