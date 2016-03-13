From: olof@lixom.net (Olof Johansson)
Date: Sat, 12 Mar 2016 17:14:45 -0800
Subject: [GIT PULL 2/2] ARM64: EXYNOS: mach/soc changes for v4.6, 2nd
In-Reply-To: <56CF97C2.5000305@samsung.com>
References: <1456445103-23314-1-git-send-email-k.kozlowski@samsung.com>
 <1456445103-23314-2-git-send-email-k.kozlowski@samsung.com>
 <56CF97C2.5000305@samsung.com>
Message-ID: <20160313011445.GK17502@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2016 at 09:09:38AM +0900, Krzysztof Kozlowski wrote:
> On 26.02.2016 09:05, Krzysztof Kozlowski wrote:
> > Hi Arnd, Kevin and Olof,
> > 
> > 
> > Pull request for v4.6 with ARM64 mach/soc changes.
> > 
> > This depends on change in clk tree (removal of ARCH_EXYNOS7) which is
> > pulled here.
> > 
> > 
> > Kind regards,
> > Krzysztof
> > 
> > 
> > Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> > Cc: Stephen Boyd <sboyd@codeaurora.org>
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > 
> > 
> > 
> > The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:
> > 
> >   Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc64-4.6-2
> > 
> > for you to fetch changes up to c87b3e970c70d5e27f9eb9acd09c6b5b9d589860:
> > 
> >   arm64: EXYNOS: Consolidate ARCH_EXYNOS7 symbol into ARCH_EXYNOS (2016-02-23 08:49:46 +0900)
> 
> And for easier grepping through history, below is the pull request
> for Exynos-specific change (no clk commits):
> 
> 
> The following changes since commit 85997a7cba7bc1578eb554e88f82023d85fb499a:
> 
>   clk: samsung: Don't build ARMv8 clock drivers on ARMv7 (2016-02-22 10:20:24 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc64-4.6-2
> 
> for you to fetch changes up to c87b3e970c70d5e27f9eb9acd09c6b5b9d589860:
> 
>   arm64: EXYNOS: Consolidate ARCH_EXYNOS7 symbol into ARCH_EXYNOS (2016-02-23 08:49:46 +0900)

Excellent, thanks! Merged into next/arm64.


-Olof
