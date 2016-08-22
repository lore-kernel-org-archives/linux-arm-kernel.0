From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 22 Aug 2016 14:08:14 +0200
Subject: [RESEND][PATCH v2] pinctrl: exynos: remove duplicate calls in irq
 handler
In-Reply-To: <15692f4c2b0.efa5c46c29252.3567074676558581477@zoho.com>
References: <15692f4c2b0.efa5c46c29252.3567074676558581477@zoho.com>
Message-ID: <CACRpkdbiBgzM2Z8tJRx7RxeZrjKWRSUFOKfQgEkgpWYKbCUf5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 12:45 PM, perr perr <strongbox8@zoho.com> wrote:

> Because chained_irq_enter() has already called chip->irq_mask() and
> chip->irq_ack(), also chained_irq_exit() will call chip->irq_unmask(),
> so it's not necessary to call chip->irq_*() here.
>
> Signed-off-by: Perr Zhang <strongbox8@zoho.com>
> Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Patch did not apply because of whitespace-damage, I guess due
to this:

User-Agent: Zoho Mail
X-Mailer: Zoho Mail

No idea what that is :D

But don't worry! I edited the patch by hand and now it is applied,
check the result in linux-next.

Yours,
Linus Walleij
