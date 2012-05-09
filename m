From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 09 May 2012 14:45:40 -0600
Subject: [PATCH 07/12] pinctrl: add sleep state definition
In-Reply-To: <1336470310-23709-1-git-send-email-linus.walleij@stericsson.com>
References: <1336470310-23709-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4FAAD774.6010401@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/2012 03:45 AM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> There is an IDLE definition in the pinctrl framework, but for
> ux500 SLEEP is more apropriate.
> 
> I've added some comments on the semantics of the common states
> so as to avoid misunderstandings.

> +/**
> + * @PINCTRL_STATE_DEFAULT: the state the pinctrl handle shall be put
> + *	on as default, usually this means the pins are up and ready to

"into" would be more typical than "on".
