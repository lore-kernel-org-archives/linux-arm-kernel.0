From: carlo@caione.org (Carlo Caione)
Date: Tue, 23 Feb 2016 09:58:37 +0100
Subject: [PATCH v2] MAINTAINERS: Extend info,
 add wiki and ml for meson arch
In-Reply-To: <1455575651-16157-1-git-send-email-carlo@caione.org>
References: <1455575651-16157-1-git-send-email-carlo@caione.org>
Message-ID: <CAOQ7t2Zrx7N3a=RKpr2M3R6QYDeC=8yUs61NrohvrbT=vvjLiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 11:34 PM, Carlo Caione <carlo@caione.org> wrote:
> From: Carlo Caione <carlo@endlessm.com>
>
> Update the maintainers info with wiki and mailing list for the meson
> platform. Fix a wrong file attribution and add maintainership for the
> generic meson platforms.
>
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---
>  MAINTAINERS | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 28eb61b..7f51744 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -920,12 +920,15 @@ M:        Emilio L?pez <emilio@elopez.com.ar>
>  S:     Maintained
>  F:     drivers/clk/sunxi/
>
> -ARM/Amlogic MesonX SoC support
> +ARM/Amlogic Meson SoC support
>  M:     Carlo Caione <carlo@caione.org>
>  L:     linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> +L:     linux-meson at googlegroups.com
> +W:     http://linux-meson.com/
>  S:     Maintained
> -F:     drivers/media/rc/meson-ir.c
> -N:     meson[x68]
> +F:     arch/arm/mach-meson/
> +F:     arch/arm/boot/dts/meson*
> +N:     meson

Hey Arnd,
Does this usually go through the armsoc tree?

Thanks,

-- 
Carlo Caione
