From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 24 Apr 2012 09:51:48 +0200
Subject: [PATCH 08/15] drivers/mmc: MMCI: Use correct GPIO binding for IRQ
 requests
In-Reply-To: <1334867804-31942-9-git-send-email-lee.jones@linaro.org>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
 <1334867804-31942-9-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbirMq4hn0+0hWmugKx37egEBNobG+stD59xJFBJ4m2fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2012 at 10:36 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Now there are irqdomains in place for Snowball, we can request
> GPIO IRQs directly by their binding. This replaces the previous method
> of hard-coding the hwirq using u32 values in the DT.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Why not squash this with the previous MMCI device tree patch and
update it?

Yours,
Linus Walleij
