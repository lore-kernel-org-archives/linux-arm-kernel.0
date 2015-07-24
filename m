From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 24 Jul 2015 15:34:14 +0900
Subject: [GIT PULL] ARM: defconfig: Improvements for 4.3
In-Reply-To: <1437115877-22010-1-git-send-email-k.kozlowski@samsung.com>
References: <1437115877-22010-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <CAJKOXPc0h=U_XyQ+HkP6vHmAdm6jjg4iHComktP3339VWhYALw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-07-17 15:51 GMT+09:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
> Dear Kukjin,
>
> Few defconfig related changes.
>
> Description along with a tag.
> You can find them also on the lists with my reviewed-by.
>
> Best regards,
> Krzysztof

Any comments on this pull request?

Best regards,
Krzysztof


>
>
> The following changes since commit 1c4c7159ed2468f3ac4ce5a7f08d79663d381a93:
>
>   Merge tag 'ext4_for_linus_stable' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4 (2015-07-05 16:24:54 -0700)
>
> are available in the git repository at:
>
>
>   https://github.com/krzk/linux.git tags/samsung-defconfig-4.3
>
> for you to fetch changes up to 5efedc7617df7add295702f21f11dd7e7a67b76e:
>
>   ARM: multi_v7_defconfig: Enable max77802 regulator (2015-07-16 15:57:31 +0900)
>
> ----------------------------------------------------------------
> Defconfig changes around Exynos based boards:
> 1. Enable sound on Odroid XU3 on exynos defconfig.
> 2. Enable NTC thermistors for Chromebooks on exynos and multi_v7.
> 3. Enable main PMIC regulator for Chromebooks on multi_v7.
> 4. Clean up in multi_v7 - remove old (non-existing) configs.
>
> ----------------------------------------------------------------
> Anand Moon (1):
>       ARM: exynos_defconfig: Enable CONFIG_SND_SOC_ODROIDX2 for Odroid-XU3
>
> Javier Martinez Canillas (4):
>       ARM: multi_v7_defconfig: Remove old Samsung USB PHY configs
>       ARM: multi_v7_defconfig: Enable NTC Thermistors support
>       ARM: exynos_defconfig: Enable NTC Thermistors support
>       ARM: multi_v7_defconfig: Enable max77802 regulator
>
>  arch/arm/configs/exynos_defconfig   | 3 +++
>  arch/arm/configs/multi_v7_defconfig | 5 +++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
