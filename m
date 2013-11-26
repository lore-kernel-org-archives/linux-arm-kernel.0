From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 26 Nov 2013 09:55:58 +0100
Subject: [PATCH 6/6] arm: sa1100: h3xxx: drop hand-coded
 gpio_request_array analogue
In-Reply-To: <1385048414-9812-7-git-send-email-dbaryshkov@gmail.com>
References: <1385048414-9812-1-git-send-email-dbaryshkov@gmail.com>
 <1385048414-9812-7-git-send-email-dbaryshkov@gmail.com>
Message-ID: <CACRpkdarrdJ0jep7gRHsgJJE8nFY_yXO5yuNH5cavisqd0EFsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 21, 2013 at 4:40 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:

> h3xxx_init_gpio() behaves alsmost like gpio_request_array. Also after

speling.

> all GPIO refactoring it is unused. Drop it now.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Please proceed to submit these to Russell by the patch tracker
or pull request.

Yours,
Linus Walleij
