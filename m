From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 28 Mar 2014 21:48:19 +0100
Subject: [PATCH 54/75] ARM: l2c: ux500: don't try to change the L2 cache
 auxiliary control register
In-Reply-To: <E1WTYYg-0007GW-L5@rmk-PC.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYYg-0007GW-L5@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdYDTvCuaEB1CPUAoOkJ4GdSgxEpQgTF+DRAREYxDZuSSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 28, 2014 at 4:19 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> ux500 can't change the auxiliary control register, so there's no point
> passing values to try and modify it to the l2x0 init functions.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
