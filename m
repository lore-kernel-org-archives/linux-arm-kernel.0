From: olof@lixom.net (Olof Johansson)
Date: Tue, 13 Mar 2012 17:53:06 -0700
Subject: [GIT PULL 2/4] Samsung devel-pd for v3.4
In-Reply-To: <4F5B7C81.6080301@samsung.com>
References: <4F5B7C81.6080301@samsung.com>
Message-ID: <CAOesGMg8iv=jE52sFs-np4HXuokMstZt8igHTQBJ4wJNOCae9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Mar 10, 2012 at 8:08 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Hi Arnd, Olof,
>
> This is Generic Power Domain patches for EXYNOS. Basically, Thomas' patches,
> adding support Generic Power Domain patches are in Rafael's tree,
> linux-pm/linux-next and see below merge commit.
> http://git.kernel.org/?p=linux/kernel/git/rafael/linux-pm.git;a=commit;h=dcaad77a8074b6de58e745546bc543d5538404f2
> And this adds hooking up G2D and JPEG to Generic PD.
>
> Please pull and here is my preferred resolution when merge this after
> next/board-samsung.
>
> diff --cc arch/arm/mach-exynos/mach-universal_c210.c
> index 3663aee,0262417..0b944eb
> --- a/arch/arm/mach-exynos/mach-universal_c210.c
> +++ b/arch/arm/mach-exynos/mach-universal_c210.c
> @@@ -1053,10 -981,6 +1052,7 @@@ static struct platform_device *universa
> ? ? ? ?&s5p_device_mfc,
> ? ? ? ?&s5p_device_mfc_l,
> ? ? ? ?&s5p_device_mfc_r,
> - ? ? ? &exynos4_device_pd[PD_MFC],
> - ? ? ? &exynos4_device_pd[PD_LCD0],
> - ? ? ? &exynos4_device_pd[PD_CAM],
> ?+ ? ? ?&cam_vt_dio_fixed_reg_dev,
> ? ? ? ?&cam_i_core_fixed_reg_dev,
> ? ? ? ?&cam_s_if_fixed_reg_dev,
> ? ? ? ?&s5p_device_fimc_md,
>
> If any problems, please kindly let me know.
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
> The following changes since commit 192cfd58774b4d17b2fe8bdc77d89c2ef4e0591d:
>
> ?Linux 3.3-rc6 (2012-03-03 17:08:09 -0800)
>
> are available in the git repository at:
> ?git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> next/devel-samsung-pd


Pulled, thanks!


-Olof
