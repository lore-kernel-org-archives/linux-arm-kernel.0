From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 23 Jan 2014 08:39:50 +0100
Subject: [PATCH] pinctrl: at91: use locked variant of irq_set_handler
In-Reply-To: <1390319718-12285-1-git-send-email-nicolas.ferre@atmel.com>
References: <1390319718-12285-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <CACRpkdamYAUj3nVb08ABzEw4P5YvRpXhbQce96BShHX_R7PQ-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 4:55 PM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> When setting the gpio irq type, use the __irq_set_handler_locked()
> variant instead of the irq_set_handler() to prevent false
> spinlock recursion warning.
>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: stable <stable@vger.kernel.org> # v3.12

Patch applied for fixes.

Yours,
Linus Walleij
