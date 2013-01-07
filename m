From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 07 Jan 2013 10:10:16 -0700
Subject: [PATCH 1/2] pinctrl/nomadik: simplify GPIO probe
In-Reply-To: <1357568625-5979-1-git-send-email-linus.walleij@stericsson.com>
References: <1357568625-5979-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <50EB0178.9020601@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/07/2013 07:23 AM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> Instead of jumping to a label later in the probe just return
> with an error code whenever probe() fails. Make sure to remove
> the gpiochip on irqdomain error now that we're at it.

The series,
Reviewed-by: Stephen Warren <swarren@nvidia.com>
