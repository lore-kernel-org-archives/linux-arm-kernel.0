From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 13 May 2018 17:47:37 +0200
Subject: [GIT PULL 5/5] ARM: exynos: mach/soc for v4.18
In-Reply-To: <20180513154238.22508-6-krzk@kernel.org>
References: <20180513154238.22508-1-krzk@kernel.org>
 <20180513154238.22508-6-krzk@kernel.org>
Message-ID: <CAJKOXPfn5VTR5=qiHwC=gRKohGJ5db_2sgni5YOdOHEZz3Vsvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 13, 2018 at 5:42 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
>
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
>
> are available in the git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-4.18
>
> for you to fetch changes up to 9ad9a2183bf51da7f8840f2e7087816c0fc8c91d:
>
>   ARM: exynos: Remove unused soc_is_exynos{4,5} (2018-05-13 14:07:03 +0200)
>
> ----------------------------------------------------------------
> Samsung mach/soc changes for v4.18
>
> 1. Remove at24_platform_data in S3C2440.
> 2. Fix invalid SPDX identifier.
> 3. Remove Exynos5440 entirely.
> 4. Cleanups.
> 5. Remove static mapping of SCU SFR and rely on DTS.
>
> ----------------------------------------------------------------
> Bartlomiej Zolnierkiewicz (1):
>       ARM: exynos: no need to select ARCH_HAS_BANDGAP any longer
>
> Bartosz Golaszewski (1):
>       ARM: s3c24xx: mini2440: Use device properties for at24 eeprom
>
> Krzysztof Kozlowski (1):
>       ARM: exynos: Remove support for Exynos5440

I forgot to mention here possible conflict with dma-mapping tree and
its commit 4965a68780c5 ("arch: define the ARCH_DMA_ADDR_T_64BIT
config symbol in lib/Kconfig"). Since Exynos5440 is going away,
conflict is easy to solve - just remove.

Best regards,
Krzysztof
