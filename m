From: yong.deng@magewell.com (Yong)
Date: Mon, 13 Nov 2017 16:30:29 +0800
Subject: [linux-sunxi] [PATCH v3 3/3] media: MAINTAINERS: add entries
 for Allwinner V3s CSI
In-Reply-To: <1510558631-45511-1-git-send-email-yong.deng@magewell.com>
References: <1510558631-45511-1-git-send-email-yong.deng@magewell.com>
Message-ID: <20171113163029.d0563943558192e36af7c9b0@magewell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 13 Nov 2017 15:37:11 +0800
Yong Deng <yong.deng@magewell.com> wrote:

> Signed-off-by: Yong Deng <yong.deng@magewell.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index adbf693..1ba7782 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3744,6 +3744,14 @@ M:	Jaya Kumar <jayakumar.alsa@gmail.com>
>  S:	Maintained
>  F:	sound/pci/cs5535audio/
>  
> +CSI DRIVERS FOR ALLWINNER V3s
> +M:	Yong Deng <yong.deng@magewell.com>
> +L:	linux-media at vger.kernel.org
> +T:	git git://linuxtv.org/media_tree.git
> +S:	Maintained
> +F:	drivers/media/platform/sun6i-csi/

Sorry, the path has been changed to drivers/media/platform/sunxi/sun6i-csi/.
I will fix it.

> +F:	Documentation/devicetree/bindings/media/sun6i-csi.txt
> +
>  CW1200 WLAN driver
>  M:	Solomon Peachy <pizza@shaftnet.org>
>  S:	Maintained
> -- 
> 1.8.3.1
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.


Thanks,
Yong
