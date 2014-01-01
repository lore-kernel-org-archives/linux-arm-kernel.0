From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 1 Jan 2014 23:57:59 +0100
Subject: [PATCH] MAINTAINERS: Update Allwinner sunXi maintainer files
In-Reply-To: <1388415813-6673-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1388415813-6673-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140101225759.GB3144@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 30, 2013 at 04:03:33PM +0100, Maxime Ripard wrote:
> Add entries for all files having either sunxi or one of the Allwinner flavours
> in their name.
> 
> Also elect Emilio Lopez as the maintainer of the clock driver, since he was
> already acting like it.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  MAINTAINERS | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1344816..dc39230 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -766,7 +766,12 @@ ARM/Allwinner A1X SoC support
>  M:	Maxime Ripard <maxime.ripard@free-electrons.com>
>  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
> -F:	arch/arm/mach-sunxi/
> +N:	sun[x4567]i
> +
> +ARM/Allwinner SoC Clock Support
> +M:	Emilio L?pez <emilio@elopez.com.ar>
> +S:	Maintained
> +F:	drivers/clk/sunxi/
>  
>  ARM/ATMEL AT91RM9200 AND AT91SAM ARM ARCHITECTURES
>  M:	Andrew Victor <linux@maxim.org.za>

Applied with Mike's Acked-by in sunxi/core-for-3.14

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140101/d74f18f8/attachment.sig>
