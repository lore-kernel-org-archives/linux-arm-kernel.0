From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 30 Aug 2016 10:54:25 +0100
Subject: [PATCH v8 18/18] drm/virtio: kconfig: Fixup white space.
In-Reply-To: <1472223413-7254-19-git-send-email-peter.griffin@linaro.org>
References: <1472223413-7254-1-git-send-email-peter.griffin@linaro.org>
 <1472223413-7254-19-git-send-email-peter.griffin@linaro.org>
Message-ID: <20160830095425.GK1661@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 26 Aug 2016, Peter Griffin wrote:

> Use tabs instead of spaces.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  drivers/gpu/drm/virtio/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

For my own reference:
  Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/gpu/drm/virtio/Kconfig b/drivers/gpu/drm/virtio/Kconfig
> index 90357d9..2d83932 100644
> --- a/drivers/gpu/drm/virtio/Kconfig
> +++ b/drivers/gpu/drm/virtio/Kconfig
> @@ -2,10 +2,10 @@ config DRM_VIRTIO_GPU
>  	tristate "Virtio GPU driver"
>  	depends on DRM
>  	select VIRTIO
> -        select DRM_KMS_HELPER
> -        select DRM_TTM
> +	select DRM_KMS_HELPER
> +	select DRM_TTM
>  	help
>  	   This is the virtual GPU driver for virtio.  It can be used with
> -           QEMU based VMMs (like KVM or Xen).
> +	   QEMU based VMMs (like KVM or Xen).
>  
>  	   If unsure say M.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
