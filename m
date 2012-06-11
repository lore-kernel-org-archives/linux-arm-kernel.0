From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 11 Jun 2012 22:54:57 +0200
Subject: [PATCH 03/14] mfd: ab8500-gpadc: Enable IRQF_ONESHOT when
 requesting a threaded IRQ
In-Reply-To: <1339428307-3850-4-git-send-email-lee.jones@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-4-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZrW=3siTjhGDPBZZcOTkekgX3xUUmiQnmxZ664q2eKZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 5:24 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The kernel now forces IRQs to be ONESHOT if no IRQ handler is passed.
>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
