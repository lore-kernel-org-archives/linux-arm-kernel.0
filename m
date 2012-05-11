From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 11 May 2012 13:37:13 -0600
Subject: [PATCH 07/12 v2] pinctrl: add sleep state definition
In-Reply-To: <1336725143-25563-1-git-send-email-linus.walleij@stericsson.com>
References: <1336725143-25563-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4FAD6A69.7020303@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/2012 02:32 AM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> There is an IDLE definition in the pinctrl framework, but for
> ux500 SLEEP is more apropriate.
> 
> I've added some comments on the semantics of the common states
> so as to avoid misunderstandings.
> 
> ChangeLog v1->v2:
> - Fixed terminology "on"->"into".
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

The updated patch 2/6/7 all look OK to me too now.
