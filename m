From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Jun 2013 22:28:56 +0200
Subject: [GIT PULL 05/10] Samsung common clk audio for v3.11
In-Reply-To: <51C0BC59.10907@samsung.com>
References: <51C0BC59.10907@samsung.com>
Message-ID: <201306202228.56642.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 June 2013, Kukjin Kim wrote:
> The following changes since commit 166bc934f54cef4588fc141e709e376244e70106:
> 
>    Merge branch 'v3.11-next/s3c24xx-dt-2' into v3.11-next/dt-n-clk-audio 
> (2013-06-19 03:27:44 +0900)
> 
> are available in the git repository at:
> 
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
> tags/common-clk-audio
> 
> for you to fetch changes up to 79d743c177f99d6854e152d9e7fac5bbbeb7c25e:
> 
>    clk: exynos5250: Add enum entries for divider clock of i2s1 and i2s2 
> (2013-06-19 03:28:43 +0900)
> 
> ----------------------------------------------------------------
> based on exynos-dt-2 and s3c24xx-dt-2
> - use #include for all Samsung DT
> - add clk for exynos audio subsystem (audss) and i2s
> - support audss and i2s for exynos5250
> 

Pulled into next/drivers, thanks!

	Arnd
