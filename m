From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Nov 2011 09:10:47 +0100
Subject: [PATCH 35/41] ARM: restart: u300: use new restart hook
In-Reply-To: <E1RN6so-0001Yx-4x@rmk-PC.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6so-0001Yx-4x@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdY1QDi0Y+KuBLem2xDR+ZGxMZmFN-zmLBXyUCBQq+XBGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 6, 2011 at 6:51 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> Hook these platforms restart code into the new restart hook rather
> than using arch_reset().
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for cleaning up this Russell!
Linus Walleij
