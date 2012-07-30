From: l.krishna@samsung.com (Leela Krishna Amudala)
Date: Mon, 30 Jul 2012 08:46:28 -0000
Subject: [PATCH 0/3] ARM: SAMSUNG: Move FIMD headers to include/video/
In-Reply-To: <1343637905-17764-1-git-send-email-l.krishna@samsung.com>
References: <1343637905-17764-1-git-send-email-l.krishna@samsung.com>
Message-ID: <CAL1wa8cBfgh8tMBe7L=udfwdRBOtRvfuwTSZNfZGFtsOyTxJpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding Marek.

This patchset based on Marek's comments.

Chages based on Marek comments
On Mon, Jul 30, 2012 at 2:15 PM, Leela Krishna Amudala <
l.krishna@samsung.com> wrote:

> This patchset moves the contents of regs-fb-v4.h and regs-fb.h from arch
> side
> to include/video/samsung_fimd.h
>
> This patchset is created and rebased against master branch of torvalds
> tree.
> Tested on smdk5250 board, build tested for other boards.
>
> Leela Krishna Amudala (3):
>   Move FIMD register headers to include/video/
>   arm: samsung: Include the modified FIMD header file
>   driver: Include the modified FIMD header file
>
>  arch/arm/mach-exynos/mach-nuri.c                |    2 +-
>  arch/arm/mach-exynos/mach-origen.c              |    2 +-
>  arch/arm/mach-exynos/mach-smdk4x12.c            |    2 +-
>  arch/arm/mach-exynos/mach-smdkv310.c            |    2 +-
>  arch/arm/mach-exynos/mach-universal_c210.c      |    2 +-
>  arch/arm/mach-exynos/setup-fimd0.c              |    2 +-
>  arch/arm/mach-s3c24xx/mach-smdk2416.c           |    2 +-
>  arch/arm/mach-s3c64xx/mach-anw6410.c            |    2 +-
>  arch/arm/mach-s3c64xx/mach-crag6410.c           |    2 +-
>  arch/arm/mach-s3c64xx/mach-hmt.c                |    2 +-
>  arch/arm/mach-s3c64xx/mach-mini6410.c           |    2 +-
>  arch/arm/mach-s3c64xx/mach-ncp.c                |    2 +-
>  arch/arm/mach-s3c64xx/mach-real6410.c           |    2 +-
>  arch/arm/mach-s3c64xx/mach-smartq5.c            |    2 +-
>  arch/arm/mach-s3c64xx/mach-smartq7.c            |    2 +-
>  arch/arm/mach-s3c64xx/mach-smdk6410.c           |    2 +-
>  arch/arm/mach-s5p64x0/mach-smdk6440.c           |    2 +-
>  arch/arm/mach-s5p64x0/mach-smdk6450.c           |    2 +-
>  arch/arm/mach-s5pc100/mach-smdkc100.c           |    2 +-
>  arch/arm/mach-s5pv210/mach-aquila.c             |    2 +-
>  arch/arm/mach-s5pv210/mach-goni.c               |    2 +-
>  arch/arm/mach-s5pv210/mach-smdkv210.c           |    2 +-
>  arch/arm/plat-samsung/include/plat/regs-fb-v4.h |  159 -------
>  arch/arm/plat-samsung/include/plat/regs-fb.h    |  403 -----------------
>  drivers/gpu/drm/exynos/exynos_drm_fimd.c        |    2 +-
>  drivers/video/s3c-fb.c                          |    2 +-
>  include/video/samsung_fimd.h                    |  533
> +++++++++++++++++++++++
>  27 files changed, 557 insertions(+), 586 deletions(-)
>  delete mode 100644 arch/arm/plat-samsung/include/plat/regs-fb-v4.h
>  delete mode 100644 arch/arm/plat-samsung/include/plat/regs-fb.h
>  create mode 100644 include/video/samsung_fimd.h
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120730/9ec5923f/attachment-0001.html>
