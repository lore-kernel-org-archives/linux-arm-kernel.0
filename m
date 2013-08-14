From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 14 Aug 2013 14:12:55 -0600
Subject: [PATCH v2] pinctrl: improve warning messages
In-Reply-To: <1376506966-11623-1-git-send-email-linus.walleij@linaro.org>
References: <1376506966-11623-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <520BE4C7.9020101@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/14/2013 01:02 PM, Linus Walleij wrote:
> Print out the affected group name on activation of pin mux
> settings, and warn if you cannot free a pin that should have
> been part of a certain setting.

Reviewed-by: Stephen Warren <swarren@nvidia.com>
