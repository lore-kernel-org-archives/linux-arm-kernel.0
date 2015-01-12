From: olof@lixom.net (Olof Johansson)
Date: Mon, 12 Jan 2015 14:11:31 -0800
Subject: [GIT PULL] Samsung fixes for v3.19
In-Reply-To: <54B38550.6010707@kernel.org>
References: <54B38550.6010707@kernel.org>
Message-ID: <20150112221131.GC22090@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 12, 2015 at 05:26:56PM +0900, Kukjin Kim wrote:
> Hi Arnd, Olof, Kevin
> 
> Please pull samsung fixes for v3.19.
> 
> Thanks,
> Kukjin
> 
> The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
> 
>   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
> 
> are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> v3.19-samsung-fixes
> 
> Andreas Faerber (1):
>       ARM: exynos_defconfig: Enable LM90 driver
> 
> Javier Martinez Canillas (1):
>       ARM: exynos_defconfig: Enable options for display panel support
> 
> Vivek Gautam (1):
>       arm: dts: Use pmu_system_controller phandle for dp phy
> 
>  arch/arm/boot/dts/exynos5250.dtsi |    2 +-
>  arch/arm/boot/dts/exynos5420.dtsi |    4 ++--
>  arch/arm/configs/exynos_defconfig |   18 +++++++++++++++++-
>  3 files changed, 20 insertions(+), 4 deletions(-)

Please write a tag description and sign it. You used to do this, why stop?

Also, you're not explaining what these patches fixes. I can see the usefulness
in the display configuration options, but I'm less sure why 3.19 needs the LM90
driver if it's just for consistency?

Finally, please explain why pmu breaks. Sounds like an incompatible binding
change?


-Olof
