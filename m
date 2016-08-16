From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 16 Aug 2016 11:56:14 +0200
Subject: [PATCH v2] clocksource/drivers/time-armada-370-xp: Fix the clock
 reference
In-Reply-To: <1470834867-25932-1-git-send-email-gregory.clement@free-electrons.com>
References: <1470834867-25932-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <57B2E33E.2030408@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2016 03:14 PM, Gregory CLEMENT wrote:
> While converting the init function to return an error, the wrong clock
> was get. This lead to wrong clock rate and slow down the kernel. For
> example, before the patch a typical boot was around 15s after it was 1
> minute slower.
> 
> Fixes: 12549e27c63c ("clocksource/drivers/time-armada-370-xp: Convert init function to return error")
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---

Applied.

Thanks Clement !

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
