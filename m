From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 19 Mar 2012 19:55:27 -0600
Subject: [PATCH v4 01/10] PWM: add pwm framework support
In-Reply-To: <1331740593-10807-2-git-send-email-thierry.reding@avionic-design.de>
References: <1331740593-10807-1-git-send-email-thierry.reding@avionic-design.de>
 <1331740593-10807-2-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <4F67E38F.6080300@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/14/2012 09:56 AM, Thierry Reding wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> This patch adds framework support for PWM (pulse width modulation) devices.
...
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
...
> +/**
> + * pwmchip_add() - register a new pwm
> + * @chip: the pwm
> + *
> + * register a new pwm. pwm->pwm_id must be initialized. if pwm_id < 0 then
> + * a dynamically assigned id will be used, otherwise the id specified,
> + */

I don't see anywhere in the code that implements "if pwm_id < 0 then a
dynamically assigned id will be used".
