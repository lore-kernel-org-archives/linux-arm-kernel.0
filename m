From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2017 21:23:29 -0800
Subject: [GIT PULL 4/4] arm64: dts: exynos: for v4.11, 2nd round
In-Reply-To: <20170129200630.22083-4-krzk@kernel.org>
References: <20170129200630.22083-1-krzk@kernel.org>
 <20170129200630.22083-4-krzk@kernel.org>
Message-ID: <20170130052329.GZ18943@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On Sun, Jan 29, 2017 at 10:06:29PM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> On top of previous pull request.
> 
> This adds proper clocks to LPASS node on Exynos5433 which is needed
> by Marek's patchset:
>  - [PATCH v2 0/8] Pad retentions support for Exynos5433
>    https://lkml.kernel.org/r/1485419634-28331-1-git-send-email-m.szyprowski () samsung ! com
> 
> 
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> 
> Best regards,
> Krzysztof
> 
> 
> The following changes since commit e4e381133241a27d732e78be09973b89a193eaf7:
> 
>   arm64: dts: exynos: Enable HDMI/TV path on Exynos5433-TM2 (2017-01-11 18:20:28 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-4.11-2
> 
> for you to fetch changes up to 7547162ac351483df3641f64e99e10be329dd6a2:
> 
>   arm64: dts: exynos: Add clocks to Exynos5433 LPASS module (2017-01-26 22:04:20 +0200)

I think you tagged the wrong branch here. The log message shows the right hash
at the tip, but the tag is of 95648b747071d530b5bb983735cfe0ffff1b66bf, which
seems to be on your for-next.

Care to respin, so your tag and our merged branch match up?


Thanks!


-Olof
