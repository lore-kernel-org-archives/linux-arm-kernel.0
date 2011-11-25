From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 25 Nov 2011 22:41:13 +0100
Subject: [PATCH 13/41] ARM: restart: integrator: use new restart hook
In-Reply-To: <E1RN6lZ-0001XR-VU@rmk-PC.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6lZ-0001XR-VU@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdZnvN2g=MZyKXaYrccjrfsphhD7g2nb0RS7pMCY5vaEiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 6, 2011 at 6:44 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> Hook these platforms restart code into the new restart hook rather
> than using arch_reset().
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Since I tend to play around with this machine,
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
