From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 04 Dec 2014 17:24:14 +0100
Subject: [GIT PULL v3 2/4] ARM: tegra: Device tree changes for v3.19
In-Reply-To: <1417707950-7633-2-git-send-email-thierry.reding@gmail.com>
References: <1417707950-7633-1-git-send-email-thierry.reding@gmail.com>
 <1417707950-7633-2-git-send-email-thierry.reding@gmail.com>
Message-ID: <25932693.6J1SFYEMJN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 December 2014 16:45:50 Thierry Reding wrote:
> Hi ARM SoC maintainers,
> 
> The following changes since commit 8918465163171322c77a19d5258a95f56d89d2e4:
> 
>   memory: Add NVIDIA Tegra memory controller support (2014-12-04 16:11:47 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-3.19-dt
> 
> for you to fetch changes up to 5b605d4426e1dc38b6572bd42c151ad247359e3a:
> 
>   ARM: tegra: Enable IOMMU for display controllers on Tegra124 (2014-12-04 16:16:15 +0100)
> 
> Note that this pulls in the for-3.19/iommu branch (tegra-for-3.19-iommu
> tag) to resolve the dependency between the IOMMU driver addition and the
> DT changes that include dt-bindings/memory/tegra*-mc.h headers.
> 

Pulled into next/dt2 to resolve the dependencies. This won't be part of
the initial set of pull requests for the merge window but will be slightly
delayed until all other dependencies are upstream and should still be
there in time for -rc1.

	Arnd
