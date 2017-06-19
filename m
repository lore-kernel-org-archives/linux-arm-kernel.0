From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Jun 2017 21:01:54 -0700
Subject: [GIT PULL 3/4] ARM: tegra: Device tree changes for v4.13-rc1
In-Reply-To: <20170616081306.11505-3-thierry.reding@gmail.com>
References: <20170616081306.11505-1-thierry.reding@gmail.com>
 <20170616081306.11505-3-thierry.reding@gmail.com>
Message-ID: <20170619040154.GF30022@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 16, 2017 at 10:13:05AM +0200, Thierry Reding wrote:
> Hi ARM SoC maintainers,
> 
> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> 
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.13-arm-dt
> 
> for you to fetch changes up to 508d690e94218d306ab2092d6ee95ca75f9fa98b:
> 
>   ARM: dts: tegra: fix PCI bus dtc warnings (2017-06-13 16:49:57 +0200)
> 
> Thanks,
> Thierry
> 
> ----------------------------------------------------------------
> ARM: tegra: Device tree changes for v4.13-rc1
> 
> This removes support for the Whistler board, which only a handful of
> people ever had access to and which doesn't provide any features over
> other Tegra20 devices that we support.
> 
> Also this cleans up some PCI related device tree content in preparation
> for a future DTC release that has additional checks for the PCI bus.

Merged, thanks.


-Olof
