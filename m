From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 18 Dec 2013 13:56:45 -0700
Subject: [PATCH 1/2] ARM: tegra: fix missing pincontrol configuration
 for Venice2
In-Reply-To: <1387371179-16725-1-git-send-email-ldewangan@nvidia.com>
References: <1387371179-16725-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <52B20C0D.9030200@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/18/2013 05:52 AM, Laxman Dewangan wrote:
> Compare the initial population of default pinmux configuration of Venice2
> with the chrome branch and add/fix the missing configurations.

Wow, that's a big chunk of changes. Are you sure this is correct? Why
was the original patch (which added the pinctrl nodes) so incorrect?

Thierry, I thought you had mentioned comparing the pinctrl setup in
linux-next with the downstream kernel for Venice2 and only found a
difference in the PWM settings, which you sent a patch for. However,
this patch is much larger than that. Where's the disconnect?
