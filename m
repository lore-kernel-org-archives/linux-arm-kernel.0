From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 20 Mar 2017 18:58:41 +0200
Subject: [PATCH] MAINTAINERS: pinctrl: Add git tree to Samsung pinctrl
 entry
In-Reply-To: <20170320164851.5999-1-krzk@kernel.org>
References: <20170320164851.5999-1-krzk@kernel.org>
Message-ID: <20170320165841.gpbevoscf2fjvods@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 06:48:51PM +0200, Krzysztof Kozlowski wrote:
> Add a Git tree on @kernel.org for maintaining the Samsung pinctrl
> drivers.  The tree will be maintained in a shared model between current
> Samsung pinctrl maintainers.  Pull requests will be going to Linus
> Walleij.
> 
> Also add the patchwork for linux-samsung-soc mailing list which will be
> used for handling the patches.
> 
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> As of now, only I have the access to this git tree. Tomasz is welcomed
> to join anytime. We are also waiting for Sywlester to get account on
> kernel.org.
> 
> For the Patchwork, I use it also for Exynos/Samsung ARM architecture
> maintenance.  I will add appropriate permissions to Sylwester so we can
> share it.
> ---

Linus,

I talked with Sylwester few days ago and we agreed on a shared mainainer
model.  Mostly because:
1. Only Sylwester from three of us works in Samsung,
2. It helps distributing the load in case of any holidays/travel etc,
3. It might also make easier for future transitions.

For this release I can start taking the patches. Please let me know:
1. Can I base on Torvalds' rc-1 or you prefer basing on top of your
   branches? In the second case your branches should not be rebased.
2. When do you expect pull requests (preferred time and acceptable late
   stuff)?


Also, I will add this tree to the linux-next + auto-builders.

Best regards,
Krzysztof
