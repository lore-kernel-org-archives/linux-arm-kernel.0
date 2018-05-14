From: olof@lixom.net (Olof Johansson)
Date: Mon, 14 May 2018 01:00:31 -0700
Subject: [GIT PULL] ARM: tegra: Device tree fixes for v4.17
In-Reply-To: <20180504153825.1074-1-thierry.reding@gmail.com>
References: <20180504153825.1074-1-thierry.reding@gmail.com>
Message-ID: <20180514080031.nvp2dzyvg4ojie2x@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2018 at 05:38:25PM +0200, Thierry Reding wrote:
> Hi ARM SoC maintainers,
> 
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.17-fixes
> 
> for you to fetch changes up to 9bf4e370048d2bbae5262d0c6280e0142804a272:
> 
>   ARM: dts: tegra20: Revert "Fix ULPI regression on Tegra20" (2018-05-04 17:32:29 +0200)
> 
> Thanks,
> Thierry
> 
> ----------------------------------------------------------------
> ARM: tegra: Device tree fixes for v4.17
> 
> This contains a single revert for a patch that was merged in v4.17-rc1
> and that turns out to cause a regression on some boards. Further, the
> original issue that the patch was supposed to fix seems to have
> disappeared.

Merged, thanks.


-Olof
