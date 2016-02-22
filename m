From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 22 Feb 2016 10:04:01 -0800
Subject: [PATCH] ARM: tegra: add "jedec,spi-nor" flash compatible binding
In-Reply-To: <1439705605-9127-1-git-send-email-zajec5@gmail.com>
References: <1439705605-9127-1-git-send-email-zajec5@gmail.com>
Message-ID: <20160222180401.GA115735@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 16, 2015 at 08:13:25AM +0200, Rafa? Mi?ecki wrote:
> Starting with commit 8947e396a829 ("Documentation: dt: mtd: replace
> "nor-jedec" binding with "jedec, spi-nor"") we have "jedec,spi-nor"
> binding indicating support for JEDEC identification.
> 
> Use it for all flashes that are supposed to support READ ID op according
> to the datasheets.
> 
> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
> ---
>  arch/arm/boot/dts/tegra114-dalmore.dts    | 2 +-
>  arch/arm/boot/dts/tegra124-jetson-tk1.dts | 2 +-
>  arch/arm/boot/dts/tegra124-nyan.dtsi      | 2 +-
>  arch/arm/boot/dts/tegra124-venice2.dts    | 2 +-
>  arch/arm/boot/dts/tegra20-trimslice.dts   | 2 +-
>  arch/arm/boot/dts/tegra30-beaver.dts      | 2 +-
>  arch/arm/boot/dts/tegra30-cardhu.dtsi     | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)

FWIW:

Acked-by: Brian Norris <computersforpeace@gmail.com>
