From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 5 Nov 2018 15:30:11 +0100
Subject: [PATCH] clocksource: imx-gpt: remove unnecessary irq protection
In-Reply-To: <20181105141511.30657-1-peron.clem@gmail.com>
References: <20181105141511.30657-1-peron.clem@gmail.com>
Message-ID: <daf4fbee-b433-62c7-9dc6-e6fff058568d@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/2018 15:15, Cl?ment P?ron wrote:
> shutdown and oneshot are already protected against irq interruptions
> 
> Signed-off-by: Cl?ment P?ron <peron.clem@gmail.com>
> ---

Applied, thanks!

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
