From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 06 Mar 2012 14:21:43 -0700
Subject: [PATCH] pinctrl: split pincontrol states into its own header
In-Reply-To: <1331068552-16988-1-git-send-email-linus.walleij@stericsson.com>
References: <1331068552-16988-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4F567FE7.4020507@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/2012 02:15 PM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> Move the pin control state defines into its own header file,
> since it is used both by machine.h which is facing the platform
> and by consumer.h which is facing the drivers, and pinctrl.h
> which is pinctrl-driver internal, let's not have each and every
> .h file include all others, then isolation is moot.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Sure. I'm not quite sure how many (or how many standardized) states we
expect to have such that it warrants 'pinctrl-state.h' vs. say
'pinctrl-common.h', but it's probably fine.

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
