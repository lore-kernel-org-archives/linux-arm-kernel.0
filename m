From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 26 Oct 2016 17:22:53 +0200
Subject: [PATCH v2] clocksource/arm_arch_timer: Map frame with
 of_io_request_and_map()
In-Reply-To: <20161026073550.22918-1-sboyd@codeaurora.org>
References: <20161026073550.22918-1-sboyd@codeaurora.org>
Message-ID: <7737749e-ba1d-9a94-f712-2d799f4c4089@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/10/2016 09:35, Stephen Boyd wrote:
> Let's use the of_io_request_and_map() API so that the frame
> region is protected and shows up in /proc/iomem.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

Applied for 4.10.

Thanks!

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
