From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 25 Nov 2011 22:44:01 +0100
Subject: [PATCH 41/41] ARM: restart: remove the now empty arch_reset()
In-Reply-To: <E1RN6ul-0001ZP-07@rmk-PC.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6ul-0001ZP-07@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdZ-w5k-wJTr3Y=X_Cqj41cF_twNCdFOYrkNCgbwoVYZmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 6, 2011 at 6:53 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> Remove the now empty arch_reset() from all the mach/system.h includes,
> and remove its callsite. ?Remove arm_machine_restart() as this function
> no longer does anything useful.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
