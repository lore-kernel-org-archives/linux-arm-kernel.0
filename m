From: olof@lixom.net (Olof Johansson)
Date: Sat, 14 Jul 2018 14:21:21 -0700
Subject: [GIT PULL 4/5] ARM: tegra: Device tree changes for v4.19-rc1
In-Reply-To: <20180712154128.22705-5-thierry.reding@gmail.com>
References: <20180712154128.22705-1-thierry.reding@gmail.com>
 <20180712154128.22705-5-thierry.reding@gmail.com>
Message-ID: <20180714212121.plis3ip3pp26jr6f@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 12, 2018 at 05:41:27PM +0200, Thierry Reding wrote:
> Hi ARM SoC maintainers,
> 
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> 
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.19-arm-dt
> 
> for you to fetch changes up to 5def854e370ff5c52172fb185932fdbffbf15692:
> 
>   ARM: dts: tegra: enable NAND flash on Colibri T20 (2018-07-09 18:51:01 +0200)
> 
> Thanks,
> Thierry
> 
> ----------------------------------------------------------------
> ARM: tegra: Device tree changes for v4.19-rc1
> 
> This set of changes adds support for the memory client resets on Tegra20
> and Tegra30, fixes a couple of issues on Cardhu and Tegra30 Apalis as
> well as adds a unit-address to the memory node to avoid warnings from
> DTC. To round things of, the NAND flash controller is enabled on the
> Tegra20 Colibri.

Merged, thanks.


-Olof
