From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 08 Oct 2015 07:25:10 +0900
Subject: [GIT PULL] ARM: dts: Exynos improvements for 4.4-2
In-Reply-To: <1444096492-15166-1-git-send-email-k.kozlowski@samsung.com>
References: <1444096492-15166-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <56159BC6.3050101@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/15 10:54, Krzysztof Kozlowski wrote:
> Dear Kukjin,
> 
> This is an updated pull request with DTS related changes for 4.4.
> 
> Description along with a tag.
> You can find them also on the lists with my reviewed-by.
> 
> Best regards,
> Krzysztof
> 
> 
> The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:
> 
>   Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/krzk/linux.git tags/samsung-dt-4.4-2
> 
> for you to fetch changes up to c21dbcfefc9dc9abc42971dc1f2681b6a8677c3c:
> 
>   ARM: dts: Remove regulator-compatible usage in exynos4412-trats2 (2015-10-06 10:47:13 +0900)
> 
> ----------------------------------------------------------------
> Device Tree improvements for Exynos based boards (updated pull request):
> 1. Enable DMA on Exynos4 serial ports. This old patch uncovered
>    a number of other issues in dmaengine and samsung serial driver.
>    All of known issues are resolved so finally enable the DMA for UART.
> 2. Fix incorrect location of display-timings node (FIMD->DP node)
>    on Arndale, SMDK5250 and SMDK5240 boards.
> 3. Minor cleanups.
> 
> ----------------------------------------------------------------
> Javier Martinez Canillas (1):
>       ARM: dts: Remove regulator-compatible usage in exynos4412-trats2
> 
> Robert Baldyga (1):
>       ARM: dts: Add DMA support for serial ports in exynos4
> 
> Sean Paul (1):
>       ARM: dts: Move display-timings node from fimd to dp in exynos5250-arndale, smdk5250 and smdk5420
> 
> Tobias Jakobi (2):
>       ARM: dts: Remove redundant pinctrl settings in exynos4412-odroid
>       ARM: dts: Unify voltage regulator style in exynos4412-odroid
> 
> Vladimir Zapolskiy (1):
>       ARM: dts: Fix cpu compatible value for s3c2416
> 
>  arch/arm/boot/dts/exynos4.dtsi                  |   8 ++
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi |  12 +--
>  arch/arm/boot/dts/exynos4412-trats2.dts         | 105 ++++++++----------------
>  arch/arm/boot/dts/exynos5250-arndale.dts        |   8 +-
>  arch/arm/boot/dts/exynos5250-smdk5250.dts       |  16 ++--
>  arch/arm/boot/dts/exynos5420-smdk5420.dts       |   7 +-
>  arch/arm/boot/dts/s3c2416.dtsi                  |   2 +-
>  7 files changed, 62 insertions(+), 96 deletions(-)

Pulled, thanks.

- Kukjin
