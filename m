From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 May 2015 17:14:22 +0200
Subject: [GIT PULL] ARM: mvebu: fixes for v4.1 #2
In-Reply-To: <5555EF50.3030206@free-electrons.com>
References: <5555EF50.3030206@free-electrons.com>
Message-ID: <2203878.yJO43gjIyk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 May 2015 15:06:24 Gregory CLEMENT wrote:
> Hi,
> 
> Here is the second pull request for fixes for mvebu for v4.2.
> Beside the usual fixes I also included an update on the MAINTAINER
> file which was sent a few months ago but which had never been merged.
> 
> Gregory
> 
> The following changes since commit 750e30d4076ae5e02ad13a376e96c95a2627742c:
> 
>   ARM: mvebu: armada-xp-openblocks-ax3-4: Disable internal RTC (2015-04-27 09:27:18 +0200)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.1-2
> 
> for you to fetch changes up to 31c17ac98fc005c0998f890094eb8fe17061e667:
> 
>   MAINTAINERS: Add dts entries for some of the Marvell SoCs (2015-05-15 14:25:43 +0200)
> 
> ----------------------------------------------------------------
> mvebu fixes for 4.1 (part 2)
> 
> Fix the main PLL frequency on Armada 375, 38x and 39x SoCs
> Add clock-names to CuBox Si5351 clk generator
> Add dts entries in the MAINTAINERS file
> 
> ----------------------------------------------------------------
> Gregory CLEMENT (2):
>       ARM: mvebu: Fix the main PLL frequency on Armada 375, 38x and 39x SoCs
>       MAINTAINERS: Add dts entries for some of the Marvell SoCs
> 
> Sebastian Hesselbarth (1):
>       ARM: dove: Add clock-names to CuBox Si5351 clk generator
> 
>  MAINTAINERS                       | 10 +++++++++-
>  arch/arm/boot/dts/armada-375.dtsi |  2 +-
>  arch/arm/boot/dts/armada-38x.dtsi |  2 +-
>  arch/arm/boot/dts/armada-39x.dtsi |  2 +-
>  arch/arm/boot/dts/dove-cubox.dts  |  1 +
>  5 files changed, 13 insertions(+), 4 deletions(-)
> 
> 

Pulled into fixes, thanks!

	Arnd
