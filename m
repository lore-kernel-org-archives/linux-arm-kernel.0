From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 28 Mar 2014 21:46:51 +0100
Subject: [PATCH 46/75] ARM: l2c: ux500: implement dummy write_sec method
In-Reply-To: <E1WTYY1-0007Fx-PG@rmk-PC.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYY1-0007Fx-PG@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdaveJF-7zny9sFFSsGuzAjGN49POq8LbYWRiApm9-MXeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 28, 2014 at 4:18 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> ux500 can't write to any of the secure registers on the L2C controllers,
> so provide a dummy handler which ignores all writes.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
