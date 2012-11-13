From: johnstul@us.ibm.com (John Stultz)
Date: Tue, 13 Nov 2012 11:06:49 -0800
Subject: [PATCH] clocksource: arm_generic: use integer math helpers
In-Reply-To: <1351520658-23028-1-git-send-email-linus.walleij@linaro.org>
References: <1351520658-23028-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <50A29A49.1050903@us.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/29/2012 07:24 AM, Linus Walleij wrote:
> This will make the two crucial integer divisions in the generic
> ARM arch timer used for ARMv8 use the kernel DIV_ROUND_CLOSEST()
> helper inline from <linux/kernel.h> so they get more precise.
>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied. Thanks
-john
