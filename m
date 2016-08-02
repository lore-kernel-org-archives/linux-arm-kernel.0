From: will.deacon@arm.com (Will Deacon)
Date: Tue, 2 Aug 2016 10:48:00 +0100
Subject: [PATCH] arm64: do away with ARCH_[WANT_OPTIONAL|REQUIRE]_GPIOLIB
In-Reply-To: <1470123981-9800-1-git-send-email-linus.walleij@linaro.org>
References: <1470123981-9800-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20160802094800.GC22621@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 02, 2016 at 09:46:21AM +0200, Linus Walleij wrote:
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
> I see you must have missed this patch. Please ACK this rebased
> version so I can send it upstream in this (v4.8) merge window.
> ---

Sorry about that:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
