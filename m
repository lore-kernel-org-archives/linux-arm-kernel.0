From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 25 Oct 2013 03:51:52 -0700
Subject: [GIT PULL V2] ARM: tegra: core SoC support changes for 3.13
In-Reply-To: <1382136027-4937-1-git-send-email-swarren@wwwdotorg.org> (Stephen
 Warren's message of "Fri, 18 Oct 2013 16:40:27 -0600")
References: <1382136027-4937-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <87sivppqrb.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> writes:

> This branch includes:
> * SoC fuse values are used as device randomness at boot.
> * Initial support for the Tegra124 SoC is added. When coupled with an
>   appropriate clock driver, which should also be merged for 3.13, we are
>   able to boot to user-space using an initrd.
> * The powergate code gains support for Tegra114.
>
> This branch is based on previous pull request tegra-for-3.13-cleanup.
>
> ----------------------------------------------------------------
>
> The following changes since commit b6bda4e0d23815cb711c16085e03cb23c6d49f21:
>
>   ARM: tegra: fix ARCH_TEGRA_114_SOC select sort order
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.13-soc-v2
>
> for you to fetch changes up to bd6a9ddcb9f2cb19dae0509341a4cbaf40dc66f0:
>
>   ARM: tegra: Add Tegra114 powergate support
>
> ----------------------------------------------------------------

Thanks for the respin, pulled into next/soc.

Kevin 
