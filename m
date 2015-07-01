From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 01 Jul 2015 13:42:56 -0700
Subject: [GIT PULL] ARM: mvebu: dt changes for v4.2
In-Reply-To: <5583214D.6020205@free-electrons.com> (Gregory CLEMENT's message
 of "Thu, 18 Jun 2015 21:51:41 +0200")
References: <5583214D.6020205@free-electrons.com>
Message-ID: <7hvbe3licv.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gregory CLEMENT <gregory.clement@free-electrons.com> writes:

> Hi,
>
> Here is the third pull request for cleanup for mvebu for v4.2.
> This pull request came very late, but as explained in the signed tag,
> without it spi muxing will be broken in 4.2-rc1 for Armada XP.
>
> Gregory
>
> The following changes since commit 2d2959286017f5501187cfa47d3854f955c4beae:
>
>   ARM: mvebu: use improved armada spi device tree compatible name for each SoC (2015-05-27 12:04:45 +0200)
>
> are available in the git repository at:
>
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.2-3
>
> for you to fetch changes up to 8c19a731a1a8b1f447a972174d2b2fe30d625518:
>
>   ARM: mvebu: adjust Armada XP DT spi muxing after pinctrl function rename (2015-06-17 15:42:15 +0200)
>
> ----------------------------------------------------------------
> mvebu dt changes for v4.2 (part #3)
>
> Update Armada XP DT spi muxing after pinctrl function rename which was
> merged in the pinctrl subsystem for 4.2. Without it the spi muxing
> will be broken in 4.2-rc1 for Armada XP.
>
> ----------------------------------------------------------------

Pulled this into next/late and will try to get in for -rc1, but if not
it will make it for -rc2.

Thanks,

Kevin
