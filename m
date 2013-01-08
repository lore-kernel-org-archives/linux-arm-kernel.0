From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 08 Jan 2013 15:32:36 -0700
Subject: [PATCH v2] pinctrl: nomadik: Add "ste,config" property etc
In-Reply-To: <1357643150-20250-1-git-send-email-linus.walleij@stericsson.com>
References: <1357643150-20250-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <50EC9E84.9080904@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/2013 04:05 AM, Linus Walleij wrote:
> From: Gabriel Fernandez <gabriel.fernandez@stericsson.com>
> 
> The "ste,config" property will contain the pin config node.
> It will be easier to define a pin configuration and use it by
> reference without duplicating lines tedious.
> 
> Other cleanups to the initial DT patch. This will all be
> squashed into the original DT submission.

Reviewed-by: Stephen Warren <swarren@nvidia.com>
