From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 26 Feb 2016 09:09:38 +0900
Subject: [GIT PULL 2/2] ARM64: EXYNOS: mach/soc changes for v4.6, 2nd
In-Reply-To: <1456445103-23314-2-git-send-email-k.kozlowski@samsung.com>
References: <1456445103-23314-1-git-send-email-k.kozlowski@samsung.com>
 <1456445103-23314-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <56CF97C2.5000305@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26.02.2016 09:05, Krzysztof Kozlowski wrote:
> Hi Arnd, Kevin and Olof,
> 
> 
> Pull request for v4.6 with ARM64 mach/soc changes.
> 
> This depends on change in clk tree (removal of ARCH_EXYNOS7) which is
> pulled here.
> 
> 
> Kind regards,
> Krzysztof
> 
> 
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> 
> 
> 
> The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:
> 
>   Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc64-4.6-2
> 
> for you to fetch changes up to c87b3e970c70d5e27f9eb9acd09c6b5b9d589860:
> 
>   arm64: EXYNOS: Consolidate ARCH_EXYNOS7 symbol into ARCH_EXYNOS (2016-02-23 08:49:46 +0900)

And for easier grepping through history, below is the pull request
for Exynos-specific change (no clk commits):


The following changes since commit 85997a7cba7bc1578eb554e88f82023d85fb499a:

  clk: samsung: Don't build ARMv8 clock drivers on ARMv7 (2016-02-22 10:20:24 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc64-4.6-2

for you to fetch changes up to c87b3e970c70d5e27f9eb9acd09c6b5b9d589860:

  arm64: EXYNOS: Consolidate ARCH_EXYNOS7 symbol into ARCH_EXYNOS (2016-02-23 08:49:46 +0900)

----------------------------------------------------------------
Samsung Exynos ARM64 improvements for v4.6:
1. Remove separate ARCH_EXYNOS7 symbol and consolidate it into
   one ARCH_EXYNOS.
   This depends on clk tree: removal of last presence of ARCH_EXYNOS7.

----------------------------------------------------------------
Krzysztof Kozlowski (2):
      Merge branch 'clk-samsung' of git://git.kernel.org/.../clk/linux into next/soc64
      arm64: EXYNOS: Consolidate ARCH_EXYNOS7 symbol into ARCH_EXYNOS

 arch/arm64/Kconfig.platforms        | 11 ++---------
 arch/arm64/boot/dts/exynos/Makefile |  2 +-
 arch/arm64/configs/defconfig        |  2 +-
 3 files changed, 4 insertions(+), 11 deletions(-)
