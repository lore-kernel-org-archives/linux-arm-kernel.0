From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 20 Dec 2013 11:41:12 -0800
Subject: [GIT PULL 0/3] Renesas ARM based SoC fixes for v3.13
In-Reply-To: <cover.1386899269.git.horms+renesas@verge.net.au> (Simon Horman's
 message of "Fri, 13 Dec 2013 11:30:24 +0900")
References: <cover.1386899269.git.horms+renesas@verge.net.au>
Message-ID: <87d2krgvjb.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simon Horman <horms+renesas@verge.net.au> writes:

> Hi Olof, Hi Kevin, Hi Arnd,
>
> please consider these Renesas ARM based SoC fixes for v3.13.
>
> The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:
>
>   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes-for-v3.13
>
> for you to fetch changes up to 23de2278ebc3a2f971ce45ca5e5e35c9d5a74040:
>
>   ARM: shmobile: r8a7790: Fix GPIO resources in DTS (2013-11-28 17:04:39 +0900)
>
> ----------------------------------------------------------------
> Renesas ARM based SoC fixes for v3.13
>
> * r8a7790 (R-Car H1) SoC
>   - Correct GPIO resources in DT.
>
>     This problem has been present since GPIOs were added to the r8a7790 SoC
>     by f98e10c88aa95bf7 ("ARM: shmobile: r8a7790: Add GPIO controller
>     devices to device tree") in v3.12-rc1.
>
> * irqchip renesas-intc-irqpin
>   - Correct register bitfield shift calculation
>
>     This bug has been present since the renesas-intc-irqpin driver was
>     introduced by 443580486e3b9657 ("irqchip: Renesas INTC External IRQ pin
>     driver") in v3.10-rc1
>
> * Lager board
>   - Do not build the phy fixup unless CONFIG_PHYLIB is enabled
>
>     This problem was introduced by 48c8b96f21817aad
>
> ----------------------------------------------------------------

Pulled into fixes.

Thanks,

Kevin
