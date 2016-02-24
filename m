From: olof@lixom.net (Olof Johansson)
Date: Wed, 24 Feb 2016 14:33:01 -0800
Subject: [GIT PULL 7/7] ARM: EXYNOS: Defconfig changes for v4.6
In-Reply-To: <1455496446-23779-8-git-send-email-k.kozlowski@samsung.com>
References: <1455496446-23779-1-git-send-email-k.kozlowski@samsung.com>
 <1455496446-23779-8-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20160224223301.GY10126@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 09:34:06AM +0900, Krzysztof Kozlowski wrote:
> Hi Arnd, Kevin and Olof,
> 
> Defconfig changes, pulling also a tag from RTC tree (merge
> of max77802 into max77686 RTC driver).
> 
> Kind regards,
> Krzysztof
> 
> 
> The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:
> 
>   Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-defconfig-4.6
> 
> for you to fetch changes up to 5d51f1dde207f2d5d43158da75c6608f7bfcec03:
> 
>   ARM: multi_v7_defconfig: Remove MAX77802 RTC Kconfig symbol (2016-02-05 09:11:32 +0900)
> 
> ----------------------------------------------------------------
> Defconfig (exynos and multi_v7) changes for Exynos based boards for v4.6:
> 1. exynos defconfig:
>    a. Enable NEON and accelerated crypto,
>    b. Enable s5p-secss driver (Security SubSystem block for accelerating
>       some cryptographic operations),
> 2. exynos and multi_v7: Remove MAX77802 RTC Kconfig because the driver
>    was combined into existing rtc-max77686 driver. This depends on changes
>    from RTC tree.

Merged, thanks.


-Olof
