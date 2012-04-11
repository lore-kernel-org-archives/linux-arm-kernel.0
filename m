From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 11 Apr 2012 09:43:31 -0600
Subject: [PATCH v2] pinctrl: implement pinctrl deferred probing
In-Reply-To: <1334133248-1452-1-git-send-email-linus.walleij@stericsson.com>
References: <1334133248-1452-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4F85A6A3.8050009@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2012 02:34 AM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> If drivers try to obtain pinctrl handles for a pin controller that
> has not yet registered to the subsystem, we need to be able to
> back out and retry with deferred probing. So let's return
> -EPROBE_DEFER whenever this location fails. Also downgrade the
> errors to info, maybe we will even set them to debug once the
> deferred probing is commonplace.

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
