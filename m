From: carlo@caione.org (Carlo Caione)
Date: Mon, 15 Feb 2016 23:12:08 +0100
Subject: [PATCH] MAINTAINERS: Extend info, add wiki and ml for meson arch
In-Reply-To: <1455573814-13378-1-git-send-email-carlo@caione.org>
References: <1455573814-13378-1-git-send-email-carlo@caione.org>
Message-ID: <CAOQ7t2bbv2mgKd8OzNmeOTf0PWL3Br1RP5uX-bq+TQjDwE=Wkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 11:03 PM, Carlo Caione <carlo@caione.org> wrote:
> From: Carlo Caione <carlo@endlessm.com>
>
> Update the maintainers info with wiki and mailing list for the meson
> platform. Fix a wrong file attribution and add maintainership for
> meson8b.
>
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---
>  MAINTAINERS | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 28eb61b..6e08d2a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -923,9 +923,11 @@ F: drivers/clk/sunxi/
>  ARM/Amlogic MesonX SoC support
>  M:     Carlo Caione <carlo@caione.org>
>  L:     linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> +L:     linux-meson at googlegroups.com
> +W:     http://linux-meson.com/
>  S:     Maintained
> -F:     drivers/media/rc/meson-ir.c
> -N:     meson[x68]
> +F:     arch/arm/mach-meson/
> +N:     meson[x68b]

Submitting soon a V2 since this doesn't match meson8b.

-- 
Carlo Caione
