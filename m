From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 31 Jul 2013 11:09:59 +0200
Subject: [PATCH/RESEND] clocksource: em_sti: Convert to devm_* managed
 helpers
In-Reply-To: <1375194277-2850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1375194277-2850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <51F8D467.1030400@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/30/2013 04:24 PM, Laurent Pinchart wrote:
> Replace kzalloc, clk_get, ioremap and request_irq by their managed
> counterparts to simplify error paths.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---

Sounds good.

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

[ ... ]

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
