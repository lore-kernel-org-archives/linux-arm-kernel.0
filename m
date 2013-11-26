From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 26 Nov 2013 09:53:35 +0100
Subject: [PATCH 3/6] arm: sa1100: h3100: refactor IrDA GPIO handling
In-Reply-To: <1385048414-9812-4-git-send-email-dbaryshkov@gmail.com>
References: <1385048414-9812-1-git-send-email-dbaryshkov@gmail.com>
 <1385048414-9812-4-git-send-email-dbaryshkov@gmail.com>
Message-ID: <CACRpkdZyM1LMzDbgWQy_1W==SmRg_jSPUNnuESe1jN9BFPfE-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 21, 2013 at 4:40 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:

> As GPIOs are going to move to platform device, there is no guarantee
> that they will be available at init_machine time.
>
> Request and free all GPIOs from IrDA startup/shutdown callbacks and not
> at init_machine time.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
