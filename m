From: xinliang.liu@linaro.org (Xinliang Liu)
Date: Mon, 30 May 2016 10:31:53 +0800
Subject: [path v2 7/7] drm/hisilicon/hibmc: Add maintainer for Hibmc DRM
In-Reply-To: <1464514855-108050-8-git-send-email-zourongrong@gmail.com>
References: <1464514855-108050-1-git-send-email-zourongrong@gmail.com>
 <1464514855-108050-8-git-send-email-zourongrong@gmail.com>
Message-ID: <CAGd==07sV0qaDES5D5ozvkC1FDQXZ-Z9_UCNX8vO09HKBktq3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 May 2016 at 17:40, Rongrong Zou <zourongrong@gmail.com> wrote:
> Signed-off-by: Rongrong Zou <zourongrong@gmail.com>
> Signed-off-by: Jianhua Li <lijianhua@huawei.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f466673..a8a62e0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3957,6 +3957,13 @@ T:       git git://github.com/patjak/drm-gma500
>  S:     Maintained
>  F:     drivers/gpu/drm/gma500/
>
> +DRM DRIVERS FOR HIBMC
> +M:     lijianhua <lijianhua@huawei.com>
> +M:     Rongrong Zou <zourongrong@gmail.com>
> +L:     dri-devel at lists.freedesktop.org
> +S:     Maintained
> +F:     drivers/gpu/drm/hisilicon/hibmc

Please add a "/" ad the end of this line.
And move this part into DRM DRIVERS FOR HISILICON

Thanks,
-xinliang

> +
>  DRM DRIVERS FOR HISILICON
>  M:     Xinliang Liu <z.liuxinliang@hisilicon.com>
>  R:     Xinwei Kong <kong.kongxinwei@hisilicon.com>
> --
> 1.9.1
>
