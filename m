From: seanpaul@google.com (Sean Paul)
Date: Fri, 21 Oct 2016 10:53:27 -0400
Subject: [PATCH] drm/virtio: kconfig: Fixup white space.
In-Reply-To: <1475913318-12275-1-git-send-email-peter.griffin@linaro.org>
References: <1475913318-12275-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <CAOw6vbLjxghzxVdNYADTSPSfJq51YHJQHQ5VMJEmtHqVKmu+kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 8, 2016 at 3:55 AM, Peter Griffin <peter.griffin@linaro.org> wrote:
> Use tabs instead of spaces.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>

Applied to drm-misc, thanks

> ---
>  drivers/gpu/drm/virtio/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/Kconfig b/drivers/gpu/drm/virtio/Kconfig
> index e1afc3d..81d1807 100644
> --- a/drivers/gpu/drm/virtio/Kconfig
> +++ b/drivers/gpu/drm/virtio/Kconfig
> @@ -1,10 +1,10 @@
>  config DRM_VIRTIO_GPU
>         tristate "Virtio GPU driver"
>         depends on DRM && VIRTIO
> -        select DRM_KMS_HELPER
> -        select DRM_TTM
> +       select DRM_KMS_HELPER
> +       select DRM_TTM
>         help
>            This is the virtual GPU driver for virtio.  It can be used with
> -           QEMU based VMMs (like KVM or Xen).
> +          QEMU based VMMs (like KVM or Xen).
>
>            If unsure say M.
> --
> 1.9.1
>
