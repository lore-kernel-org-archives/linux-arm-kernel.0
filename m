From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 23 Jan 2012 20:04:19 +0100
Subject: [PATCH 07/31] ARM: amba: ux500: get rid of NO_IRQ
In-Reply-To: <E1RoAiE-0005Eh-7i@rmk-PC.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
 <E1RoAiE-0005Eh-7i@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdYYn1uo9TagE9DEcaJpRm60QYVngq10CtSy4h4Q1V2qvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2012 at 10:24 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> irq 0 now means no irq, so get rid of this unnecessary initializer.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> ?arch/arm/mach-ux500/devices-common.c | ? ?1 -
> ?1 files changed, 0 insertions(+), 1 deletions(-)

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks Russell,
Linus Walleij
