From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 28 Oct 2011 21:37:29 +0200
Subject: [PATCH 42/51] ARM: mach-u300: use arm_arch_reset instead of
	arch_reset
In-Reply-To: <1319813059-8914-43-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
	<1319813059-8914-43-git-send-email-will.deacon@arm.com>
Message-ID: <CACRpkdZ9iCtb0uy_VGnOsd61PAL4+aOTFNq0RO7psf8XNAbtnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 28, 2011 at 4:44 PM, Will Deacon <will.deacon@arm.com> wrote:

> This patch updates mach-u300 to use arm_arch_reset instead of
> arch_reset.
>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Looks like a good idea so I applied patch 1 and this patch, and it JustWorks,
compiles, performs reset on the U300.

Tested-by: Linus Walleij <linus.walleij@linaro.org>
For patch 1 and 42.

Yours,
Linus Walleij
