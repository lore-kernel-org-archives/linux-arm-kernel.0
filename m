From: will.deacon@arm.com (Will Deacon)
Date: Thu, 2 Jun 2016 19:05:14 +0100
Subject: [PATCH] arm64: do away with ARCH_[WANT_OPTIONAL|REQUIRE]_GPIOLIB
In-Reply-To: <1464869670-7208-1-git-send-email-linus.walleij@linaro.org>
References: <1464869670-7208-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20160602180514.GD7697@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 02, 2016 at 02:14:30PM +0200, Linus Walleij wrote:
> This replaces:
> 
> - "select ARCH_REQUIRE_GPIOLIB" with "select GPIOLIB" as this can
>   now be selected directly.
> 
> - "select ARCH_WANT_OPTIONAL_GPIOLIB" with no dependency: GPIOLIB
>   is now selectable by everyone, so we need not declare our
>   intent to select it.
> 
> Cc: Michael B?sch <m@bues.ch>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM64/AArch64 maintainers:
> Please apply this patch directly for cleanups.

Just checking -- you're aiming to have this in 4.7-rc ?

Will
