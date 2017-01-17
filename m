From: olof@lixom.net (Olof Johansson)
Date: Mon, 16 Jan 2017 22:30:06 -0800
Subject: [GIT PULL 1/4] ARM: exynos: Mach/soc for v4.11
In-Reply-To: <20170113152030.13586-1-krzk@kernel.org>
References: <20170113152030.13586-1-krzk@kernel.org>
Message-ID: <20170117063006.GL16607@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2017 at 05:20:27PM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> Mostly cleanups for v4.11.
> 
> Best regards,
> Krzysztof
> 
> 
> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> 
>   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-4.11
> 
> for you to fetch changes up to cda1a52dab50340728e46601e6c9da9fc4beaf1f:
> 
>   ARM: s3c64xx: Constify wake_irqs (2016-12-29 15:41:44 +0200)
> 
> ----------------------------------------------------------------
> Samsung mach/soc update for v4.11. Mostly cleanups:
> 1. Removal of unused platform data in S3C24XX and S3C64xx as follow up of
>    conversion to new DMA channel request API.
> 2. Adding const and __ro_after_init to various data in Samsung platforms.
> 
> ----------------------------------------------------------------
> Krzysztof Kozlowski (7):
>       ARM: EXYNOS: Constify list of retention registers
>       ARM: EXYNOS: Annotate iomem and pm_data pointers __ro_after_init
>       ARM: s3c24xx: Constify few integer tables
>       ARM: s3c64xx: Annotate external clock frequencies __ro_after_init
>       ARM: SAMSUNG: Constify array of wake irqs passed to samsung_sync_wakemask
>       ARM: s3c24xx: Constify wake_irqs
>       ARM: s3c64xx: Constify wake_irqs
> 
> Sylwester Nawrocki (2):
>       ARM: s3c64xx: Drop initialization of unused struct s3c_audio_pdata fields
>       ARM: s3c24xx: Drop unused struct s3c_audio_pdata entries

Merged, thanks.


-Olof
