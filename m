From: olof@lixom.net (Olof Johansson)
Date: Fri, 25 May 2018 05:14:51 -0700
Subject: [GIT PULL v2 2/5] memory: tegra: Changes for v4.18-rc1
In-Reply-To: <20180518215837.29076-1-thierry.reding@gmail.com>
References: <20180518142245.20242-2-thierry.reding@gmail.com>
 <20180518215837.29076-1-thierry.reding@gmail.com>
Message-ID: <20180525121451.csz4x7xsgu5z4qmw@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2018 at 11:58:37PM +0200, Thierry Reding wrote:
> Hi ARM SoC maintainers,
> 
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.18-memory-v2
> 
> for you to fetch changes up to a1be3cfdfb81cc55c1b2feb73aca6945f61acddb:
> 
>   dt-bindings: memory: tegra: Remove Tegra114 SATA and AFI reset definitions (2018-05-18 22:45:01 +0200)
> 
> This contains the same patches as the previous pull request with the exception
> that the final two are reordered to keep the set bisectible.
> 
> Thanks,
> Thierry
> 
> ----------------------------------------------------------------
> memory: tegra: Changes for v4.18-rc1
> 
> This contains some cleanup of the memory controller driver as well as
> unification work to share more code between Tegra20 and later SoC
> generations. Also included are an implementation for the hot resets
> functionality by the memory controller which is required to properly
> reset busy hardware.
> 
> ----------------------------------------------------------------
> Dmitry Osipenko (14):
>       dt-bindings: memory: tegra: Add hot resets definitions
>       memory: tegra: Do not handle spurious interrupts
>       memory: tegra: Setup interrupts mask before requesting IRQ
>       memory: tegra: Apply interrupts mask per SoC
>       memory: tegra: Remove unused headers inclusions
>       memory: tegra: Squash tegra20-mc into common tegra-mc driver
>       memory: tegra: Introduce memory client hot reset
>       memory: tegra: Add Tegra20 memory controller hot resets
>       memory: tegra: Add Tegra30 memory controller hot resets
>       memory: tegra: Add Tegra114 memory controller hot resets
>       memory: tegra: Add Tegra124 memory controller hot resets
>       memory: tegra: Register SMMU after MC driver became ready
>       memory: tegra: Remove Tegra114 SATA and AFI reset definitions
>       dt-bindings: memory: tegra: Remove Tegra114 SATA and AFI reset definitions
> 
> Thierry Reding (1):
>       memory: tegra: Add Tegra210 memory controller hot resets

Merged, thanks.


-Olof
