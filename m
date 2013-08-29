From: olof@lixom.net (Olof Johansson)
Date: Thu, 29 Aug 2013 13:27:26 -0700
Subject: [GIT PULL 2/3] 2nd Round Samsung DT for v3.12
In-Reply-To: <1f7601cea1f1$3f2913d0$bd7b3b70$%kim@samsung.com>
References: <1f7601cea1f1$3f2913d0$bd7b3b70$%kim@samsung.com>
Message-ID: <20130829202726.GQ18542@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 26, 2013 at 09:14:35AM +0900, Kukjin Kim wrote:
> The following changes since commit 6f9d02a056fff8e965da0f940a09d4c39a4fe80a:
> 
>   ARM: dts: Add USB host node for Exynos4 (2013-08-19 05:07:17 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> tags/samsung-dt-2

Merged into late/all, to be merged towards the end of the merge window.

> Vikas Sajjan (3):
>       ARM: dts: Fix the RTC DT node name for Exynos5250
>       ARM: dts: Update the "status" property of RTC DT node for Exynos5250
> SoC

Next time please squash stuff like this, one adds properties and the next patch
removes them. I know Linaro likes to show up on patch contributor highscore
lists but this is nothing but churn.


-Olof
