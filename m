From: augulis.darius@gmail.com (Darius Augulis)
Date: Mon, 16 Aug 2010 20:21:45 +0300
Subject: [PULL] Please pull bjdooks' for-linus/samsung-2636
In-Reply-To: <20100814153625.GA31271@ben-laptop.fluff.org>
References: <20100814153625.GA31271@ben-laptop.fluff.org>
Message-ID: <4C6973A9.2060004@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/14/2010 06:36 PM, Ben Dooks wrote:
> Hi, please pull
>
> The following changes since commit 45d7f32c7a43cbb9592886d38190e379e2eb2226:
>    Linus Torvalds (1):
>          Merge git://git.kernel.org/.../cmetcalf/linux-tile
>
> are available in the git repository at:
>
>    git://git.fluff.org/bjdooks/linux.git for-linus/samsung-2635
>
> Ben Dooks (3):
>        ARM: S3C64XX: Update consistent DMA size to 8MiB
>        ARM: SMDK6410: Make virtual screen twice depth of real
>        Merge branch 'for-2636/s3c64xx' into for-linus/samsung-2635
>
> Darius Augulis (3):
>        ARM: S3C64XX: Support for Real6410
>        ARM: mach-real6410: add dm9000 ethernet support for mach-real6410
>        ARM: mach-real6410: add sdhc device support

Probably you would like to merge v2 of these patches.
I sent v2 to ML in 08/06/2010.
As v1 is already in main line, should I prepare new patch containing 
fixes which are in v2? These fixes mostly are coding style related also 
one minor fix in dm9000 pdata.

>
> Kukjin Kim (1):
>        ARM: SAMSUNG: Fix on build warning about dependency in Kconfig
>
> Linus Walleij (1):
>        DMAENGINE: correct PL080 register header file
>
> Maurus Cuelenaere (3):
>        ARM: S3C64XX: Move SmartQ LCD control platform definition to shared file
>        ARM: S3C64XX: Set wifi and iNAND as permanently connected SD devices on SmartQ boards
>        ARM: S3C64XX: Add audio support to SmartQ
>
> Patrick Georgi (1):
>        ARM: S3C64XX: Framebuffer fix for SmartQ5
>
>   arch/arm/include/asm/hardware/pl080.h       |    4 +-
>   arch/arm/mach-s3c64xx/Kconfig               |    9 ++
>   arch/arm/mach-s3c64xx/Makefile              |    1 +
>   arch/arm/mach-s3c64xx/dma.c                 |    2 +-
>   arch/arm/mach-s3c64xx/include/mach/memory.h |    2 +
>   arch/arm/mach-s3c64xx/mach-real6410.c       |  152 +++++++++++++++++++++++++++
>   arch/arm/mach-s3c64xx/mach-smartq.c         |   40 +++++++-
>   arch/arm/mach-s3c64xx/mach-smartq5.c        |   36 +------
>   arch/arm/mach-s3c64xx/mach-smartq7.c        |   28 -----
>   arch/arm/mach-s3c64xx/mach-smdk6410.c       |    2 +
>   arch/arm/plat-samsung/Kconfig               |    2 +-
>   11 files changed, 213 insertions(+), 65 deletions(-)
>   create mode 100644 arch/arm/mach-s3c64xx/mach-real6410.c
>
