From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 08 Oct 2013 13:24:44 +0200
Subject: [PATCH] clocksource: em_sti: convert to clk_prepare/unprepare
In-Reply-To: <1381222888-4199-2-git-send-email-horms+renesas@verge.net.au>
References: <1381222888-4199-1-git-send-email-horms+renesas@verge.net.au>
 <1381222888-4199-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <5253EB7C.9070700@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/2013 11:01 AM, Simon Horman wrote:
> From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
>
> Add calls to clk_prepare and unprepare so that EMMA Mobile EV2 can
> migrate to the common clock framework.
>
> Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Acked-by: Magnus Damm <damm@opensource.se>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---

Applied to my tree for 3.13

Thanks !

   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
