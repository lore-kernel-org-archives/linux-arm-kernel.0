From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 14 Dec 2012 15:52:05 -0700
Subject: [PATCH 2/2 v2] pinctrl/nomadik: adopt pinctrl sleep mode
 management
In-Reply-To: <1355516472-24759-1-git-send-email-linus.walleij@stericsson.com>
References: <1355516472-24759-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <50CBAD95.3090308@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/14/2012 01:21 PM, Linus Walleij wrote:
> This fix makes pinctrl-nomadik able to handle
> suspend/resume events and change hogged pins states
> accordingly.

Reviewed-by: Stephen Warren <swarren@nvidia.com>
