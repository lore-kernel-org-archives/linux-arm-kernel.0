From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 21 Aug 2013 16:34:30 -0700
Subject: [GIT PULL] Allwinner sunXi core additions for 3.12, take 2
In-Reply-To: <20130820075929.GA11906@lukather> (Maxime Ripard's message of
 "Tue, 20 Aug 2013 09:59:29 +0200")
References: <20130820075929.GA11906@lukather>
Message-ID: <87k3jeoby1.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime Ripard <maxime.ripard@free-electrons.com> writes:

> The following changes since commit 29d3d373e2a780b6e818f296ece6cc29742bc11f:
>
>   ARM: sunxi: Remove Makefile.boot file (2013-07-29 13:55:41 +0200)
>
> are available in the git repository at:
>
>   https://github.com/mripard/linux.git tags/sunxi-core-for-3.12-2
>
> for you to fetch changes up to d18fd9445b18c4adf56cfc58c378c702c8edd0da:
>
>   ARM: sunxi: Introduce Allwinner A20 support (2013-08-16 23:23:41 +0200)
>
> ----------------------------------------------------------------
> Allwinner sunXi core additions for 3.12, take 2
>
> These patches add machine support for the Allwinner A20 and A31 SoCs
>
> ----------------------------------------------------------------

Pulled into next/soc

In the future, when you do a 'take 2', it would be good to be specific
in the pull request about whether you want this to replace the original,
or you want it on top of the original.

It was pretty obvious in this case that the 2nd tag was based on top of
the first, but it's best to be be more detailed in the pull request to
avoid us assuming.

Thanks,

Kevin
