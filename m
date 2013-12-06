From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 6 Dec 2013 14:14:04 +0100
Subject: [PATCHv5][ 2/8] staging: imx-drm: Add RGB666 support for
 parallel display.
In-Reply-To: <1386268092-21719-2-git-send-email-denis@eukrea.com>
References: <1386268092-21719-1-git-send-email-denis@eukrea.com>
 <1386268092-21719-2-git-send-email-denis@eukrea.com>
Message-ID: <20131206131403.GA30960@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 05, 2013 at 07:28:06PM +0100, Denis Carikli wrote:
[...]
> diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-dc.c b/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
[...]
> @@ -155,6 +156,8 @@ static int ipu_pixfmt_to_map(u32 fmt)
>  		return IPU_DC_MAP_BGR666;
>  	case V4L2_PIX_FMT_BGR24:
>  		return IPU_DC_MAP_BGR24;
> +	case V4L2_PIX_FMT_RGB666:
> +		return IPU_DC_MAP_RGB666;

Why is this DRM driver even using V4L2 pixel formats in the first place?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131206/29376d8d/attachment.sig>
