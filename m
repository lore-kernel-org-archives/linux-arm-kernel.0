From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 17 Dec 2015 14:14:44 +0900
Subject: [RESEND PATCH v5 0/8] Add support for Exynos SROM Controller
 driver
In-Reply-To: <1449906242-20843-1-git-send-email-pankaj.dubey@samsung.com>
References: <1449906242-20843-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <567244C4.8080708@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12.12.2015 16:43, Pankaj Dubey wrote:
> THIS IS A RESEND OF ONCE MERGED INTO kgene/for-next AND LOST PATCHES
> 
> Series v5 got merged in kgene/for-next but due to last moment change before pull
> these patches were not accepted during 4.3 merge window.After that kgene/for-next
> got rebased over 4.4-rc1 these patches got dropped into another branch and till
> date not included to for-next.
> 
> Since then due to minor change in "drivers/soc/", patches are not getting applied
> cleanly so rebasing on current for-next and resending all these with fix in memory
> mapping included.
> 
> 
> This patch set adds support for Exynos SROM controller DT based driver.
> Currently SROM register sets are used only during S2R, so driver
> basically added for taking care of S2R. It will help us in removing
> static mapping from exynos.c and other extra code handline during S2R.
> 
> This patch set also updated exynos4 and exynos5 dtsi files for with device
> node for srom, and added binding documentation for the same.
> 
> First two patches are some minor cleanup in mach-exynos.
> 
> Patchset v1 was posted here[1]
> [1]: https://lkml.org/lkml/2015/4/29/98
> Patchset v2 was posted here[2]
> [2]: https://lkml.org/lkml/2015/8/24/125
> Patchset v3 was posted here[3]
> [3]: https://lkml.org/lkml/2015/10/13/392
> Patchset v3 was posted here[4]
> [4]: https://lkml.org/lkml/2015/10/19/278
> 
> This patchset, I have tested on Peach-Pi (Exynos5880) based chromebook for boot
> and S2R functionality.

Let me share the plan/status:
1. Currently Kukjin Kim is on out of office (he told me he will be back
on Christmas).
2. I asked arm-soc people to pull my requests.

3. I applied this patchset to my branch:
next/stuff-late-not-split-per-branch
https://git.kernel.org/cgit/linux/kernel/git/krzk/linux.git/log/?h=next/stuff-late-not-split-per-branch

4. This branch is not pushed to linux-next. I will sort it out if my
previous pull requests get in. I will be out of office for Christmas so
depending on the timing of arm-soc/Christmas/Kukjin this may or may not
go into v4.5 (yay...).

5. If it does not get into v4.5, I will rebase it and proceed further
for v4.6.

If you have any questions, please let me know.

Best regards,
Krzysztof
