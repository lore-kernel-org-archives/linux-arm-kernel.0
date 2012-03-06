From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 06 Mar 2012 10:28:26 -0700
Subject: [PATCH] pinctrl: include machine header to core.h
In-Reply-To: <1331038557-1398-1-git-send-email-linus.walleij@stericsson.com>
References: <1331038557-1398-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4F56493A.1090700@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/2012 05:55 AM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> struct pinctrl_setting contains an enum pinctrl_map_type
> field, so we need to include machine.h. Also fix kerneldoc
> to indicate that the pinctrl_setting is about both muxing
> and other config.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
