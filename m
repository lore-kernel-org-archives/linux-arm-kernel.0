From: felipe.balbi@linux.intel.com (Felipe Balbi)
Date: Thu, 03 Aug 2017 12:23:09 +0300
Subject: [PATCH 2/2] MAINTAINERS: add entry for mediatek usb3 DRD IP driver
In-Reply-To: <1501749439-8837-2-git-send-email-chunfeng.yun@mediatek.com>
References: <1501749439-8837-1-git-send-email-chunfeng.yun@mediatek.com>
 <1501749439-8837-2-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <87y3r1dmyq.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Chunfeng Yun <chunfeng.yun@mediatek.com> writes:
> Add myself as maintainer of MediaTek USB3 DRD IP driver
>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  MAINTAINERS |    7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 205d397..0f0bcc7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8472,6 +8472,13 @@ M:      Sean Wang <sean.wang@mediatek.com>
>  S:      Maintained
>  F:      drivers/char/hw_random/mtk-rng.c
>  
> +MEDIATEK USB3 DRD IP DRIVER
> +M:	Chunfeng Yun <chunfeng.yun@mediatek.com>
> +L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> +L:	linux-mediatek at lists.infradead.org (moderated for non-subscribers)

everything USB should go to linux-usb too.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170803/46a7e8e8/attachment.sig>
