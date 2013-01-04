From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 04 Jan 2013 13:03:57 -0700
Subject: [PATCH] pinctrl: add pinconf-generic defines for output
In-Reply-To: <1357318849-12616-1-git-send-email-linus.walleij@stericsson.com>
References: <1357318849-12616-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <50E735AD.4060008@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/2013 10:00 AM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This adds a definition of a generic output configuration
> for a certain pin when using the generic pin configuration
> library. Whereas driving pins low/high is usually a GPIO
> business, you may want to set up pins into a default state
> using hogs, and never touch them again. This helps out
> with that scenario.

Seems plausible:-) Although I wonder if this is moving towards DT
content setting up HW rather than writing drivers for things. Probably
not an issue so far though.

Reviewed-by: Stephen Warren <swarren@nvidia.com>
