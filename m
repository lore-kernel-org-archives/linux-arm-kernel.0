From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 10 Dec 2015 08:23:54 -0700
Subject: [PATCH] coresight: Fix a typo in Kconfig
In-Reply-To: <1449697147-5819-1-git-send-email-afd@ti.com>
References: <1449697147-5819-1-git-send-email-afd@ti.com>
Message-ID: <CANLsYkx8ORd44jDWA=jGrDt_UOnYw=WzOHDah3tBC+m7bEY93w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 December 2015 at 14:39, Andrew F. Davis <afd@ti.com> wrote:
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  drivers/hwtracing/coresight/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index 6c89211..c85935f 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -8,7 +8,7 @@ menuconfig CORESIGHT
>           This framework provides a kernel interface for the CoreSight debug
>           and trace drivers to register themselves with. It's intended to build
>           a topological view of the CoreSight components based on a DT
> -         specification and configure the right serie of components when a
> +         specification and configure the right series of components when a
>           trace source gets enabled.
>
>  if CORESIGHT
> --
> 1.9.1
>

Applied - thanks.
Mathieu
