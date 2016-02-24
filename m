From: olof@lixom.net (Olof Johansson)
Date: Wed, 24 Feb 2016 14:31:54 -0800
Subject: [GIT PULL 6/7] ARM: dts: Exynos stuff for v4.6
In-Reply-To: <1455496446-23779-7-git-send-email-k.kozlowski@samsung.com>
References: <1455496446-23779-1-git-send-email-k.kozlowski@samsung.com>
 <1455496446-23779-7-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20160224223154.GX10126@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 09:34:05AM +0900, Krzysztof Kozlowski wrote:
> Hi Arnd, Kevin and Olof,
> 
> Rest of DTS changes for v4.6. This also pulls early DT changes (related
> to SROM controller) because rest of patches depend on it.
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
>   git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.6
> 
> for you to fetch changes up to 36a0282a41493400428d7df8c99701fb4ee344c2:
> 
>   ARM: dts: Replace legacy *,wakeup property with wakeup-source for exynos boards (2016-01-29 09:09:49 +0900)
> 
> ----------------------------------------------------------------
> Samsung DeviceTree updates and improvements for v4.6:
> 1. Add SROM controller device nodes.
> 2. Add Ethernet chip as child of SROM controller on SMDK5410.
> 3. Allow simultaneous usage exynos-rng and s5p-sss drivers on Exynos5.
> 4. Cleanup CPU configuration on Exynos542x/5800.
> 5. Add necessary nodes for cpufreq-dt driver on Exynos542x/5800 (OPPs,
>    regulator supplies) which allows frequency and voltage scalling
>    of this SoC.
> 6. Minor cleanups.

Merged, thanks. See feedback on the other dt branch regarding subjects.


-Olof
