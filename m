From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 23 Apr 2012 14:25:21 +0200
Subject: [PATCH 02/15] drivers/gpio: gpio-nomadik: Add support for
 irqdomains
In-Reply-To: <1334867804-31942-3-git-send-email-lee.jones@linaro.org>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
 <1334867804-31942-3-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdabAJt7YbfOBCgg0hktp8sffFrf6r5zT0hrETMcijcCpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2012 at 10:36 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Add irq domain support to the gpio-nomadik GPIO driver. This
> enables its users to support dynamic IRQ assignment, which is
> requried by Device Tree.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Hey, it works!

Applied to my gpio-and-pin ux500 branch.

Note to Grant: I'm shepherding the ux500 GPIO patches for
funneling through the ARM SoC tree.

Yours,
Linus Walleij
