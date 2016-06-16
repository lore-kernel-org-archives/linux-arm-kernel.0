From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 16 Jun 2016 16:40:45 +0200
Subject: [PATCH] clocksource/drivers/digicolor: fix warning of non-static
 function
In-Reply-To: <1465308710-18297-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465308710-18297-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <5762BA6D.7020007@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/2016 04:11 PM, Ben Dooks wrote:
> Change the dc_timer function to be static as it is not used outside
> this driver. This fixes the following warning:
>
> drivers/clocksource/timer-digicolor.c:66:24: warning: symbol 'dc_timer' was not declared. Should it be static?
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---

Applied, thanks.

   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
