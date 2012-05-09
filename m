From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 09 May 2012 14:53:49 -0600
Subject: [PATCH 12/12] ARM: ux500: switch MSP to using pinctrl for pins
In-Reply-To: <1336470347-23886-1-git-send-email-linus.walleij@stericsson.com>
References: <1336470347-23886-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4FAAD95D.9010108@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/2012 03:45 AM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> The MSP platform data callbacks use the old custom callbacks to
> set the state of the pins, switch over to using pinctrl.

Aside from the comments I've already made, I guess you can consider the
whole series:

Acked-by: Stephen Warren <swarren@wwwdotorg.org>

I'm not at all familiar with this HW, and didn't look at every detail,
but at least I see no particular reason not to ack it.
