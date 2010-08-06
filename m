From: augulis.darius@gmail.com (Darius Augulis)
Date: Fri, 06 Aug 2010 13:25:06 +0300
Subject: [PATCH 0/4] s3c: mach-real6410: patches for next merge window
In-Reply-To: <20100806101914.2481.67766.stgit@darius-desktop>
References: <20100806101914.2481.67766.stgit@darius-desktop>
Message-ID: <4C5BE302.1090901@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/2010 01:20 PM, Darius Augulis wrote:
> Several patches adding support for mach-real6410
> and main platform devices. Please see inline patches
> for detail description and changelogs.

All these are tested by myself on board REAL6410 v3.2

>
> ---
>
> Darius Augulis (4):
>        s3c: add support for mach-real6410
>        s3c: mach-real6410: add support for dm9000 ethernet
>        s3c: mach-real6410: add sdhc device support
>        s3c: mach-real6410: add nand support
>
>
>   arch/arm/mach-s3c64xx/Kconfig         |   10 ++
>   arch/arm/mach-s3c64xx/Makefile        |    1
>   arch/arm/mach-s3c64xx/mach-real6410.c |  193 +++++++++++++++++++++++++++++++++
>   3 files changed, 204 insertions(+), 0 deletions(-)
>   create mode 100644 arch/arm/mach-s3c64xx/mach-real6410.c
>
