From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 01 Jun 2015 10:45:18 +0200
Subject: [PATCH] clocksource: timer-imx-gpt: remove include of
 <asm/mach/time.h>
In-Reply-To: <1432905147-23754-1-git-send-email-shawn.guo@linaro.org>
References: <1432905147-23754-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <556C1B9E.4090900@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/29/2015 03:12 PM, Shawn Guo wrote:
> The include of <asm/mach/time.h> is not needed at all, and causes build
> error in powerpc allyesconfig.  Remove it.
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
