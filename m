From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 5 Nov 2012 17:26:03 +0000
Subject: [PATCH] clocksource: arm_generic: use integer math helpers
In-Reply-To: <1351520658-23028-1-git-send-email-linus.walleij@linaro.org>
References: <1351520658-23028-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20121105172603.GG17864@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2012 at 02:24:18PM +0000, Linus Walleij wrote:
> This will make the two crucial integer divisions in the generic
> ARM arch timer used for ARMv8 use the kernel DIV_ROUND_CLOSEST()
> helper inline from <linux/kernel.h> so they get more precise.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

BTW, would this go through John's tree? I'm happy to push it as well.

Thanks.

-- 
Catalin
