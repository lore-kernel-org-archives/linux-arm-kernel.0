From: balbi@ti.com (Felipe Balbi)
Date: Wed, 20 Aug 2014 12:58:24 -0500
Subject: [PATCH v4 3/3] MAINTAINERS: Add dwc3-st.c file to ARCH/STI
 architecture
In-Reply-To: <1406734091-16202-4-git-send-email-peter.griffin@linaro.org>
References: <1406734091-16202-1-git-send-email-peter.griffin@linaro.org>
 <1406734091-16202-4-git-send-email-peter.griffin@linaro.org>
Message-ID: <20140820175824.GT24500@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 30, 2014 at 04:28:11PM +0100, Peter Griffin wrote:

-ENOLOG

> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 702ca10..269ad3b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1325,6 +1325,7 @@ F:	drivers/pinctrl/pinctrl-st.c
>  F:	drivers/media/rc/st_rc.c
>  F:	drivers/i2c/busses/i2c-st.c
>  F:	drivers/tty/serial/st-asc.c
> +F:	drivers/usb/dwc3/dwc3-st.c

also doesn't apply, please rebase on v3.17-rc1. As for the other two
patches, I'm reviewing them right now and they apply cleanly, at least.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140820/22087b06/attachment.sig>
