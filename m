From: emil.l.velikov@gmail.com (Emil Velikov)
Date: Fri, 9 Oct 2015 23:12:47 +0100
Subject: [PATCH v3 2/7] MAINTAINERS: Add myself for the new VC4 (RPi GPU)
 graphics driver.
In-Reply-To: <1444426068-15817-3-git-send-email-eric@anholt.net>
References: <1444426068-15817-1-git-send-email-eric@anholt.net>
 <1444426068-15817-3-git-send-email-eric@anholt.net>
Message-ID: <CACvgo53ftyjj=LhsNuePnjH2Bez5SAG5cwk=7gzMhmMPMYOnew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On 9 October 2015 at 22:27, Eric Anholt <eric@anholt.net> wrote:
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>
> v2: Mark it Supported, not Maintained.
>
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7ba7ab7..e331e46 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3653,6 +3653,12 @@ S:       Maintained
>  F:     drivers/gpu/drm/sti
>  F:     Documentation/devicetree/bindings/gpu/st,stih4xx.txt
>
> +DRM DRIVERS FOR VC4
> +M:     Eric Anholt <eric@anholt.net>
> +T:     git git://github.com/anholt/linux
You might want to add dri-devel as mailing list, at least initially.

> +S:     Supported
> +F:     drivers/gpu/drm/vc4/*
Imho, the binding documentation should also be listed here.

Regards,
Emil
