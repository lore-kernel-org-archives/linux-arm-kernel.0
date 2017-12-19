From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Tue, 19 Dec 2017 13:48:03 +0200
Subject: [PATCH v2 3/3] media: MAINTAINERS: add entries for Allwinner V3s
 CSI
In-Reply-To: <1501131697-1359-4-git-send-email-yong.deng@magewell.com>
References: <1501131697-1359-1-git-send-email-yong.deng@magewell.com>
 <1501131697-1359-4-git-send-email-yong.deng@magewell.com>
Message-ID: <20171219114802.gi7db7xhm3eh4udt@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 27, 2017 at 01:01:37PM +0800, Yong Deng wrote:
> Signed-off-by: Yong Deng <yong.deng@magewell.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9826a91..b91fa27 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3686,6 +3686,14 @@ M:	Jaya Kumar <jayakumar.alsa@gmail.com>
>  S:	Maintained
>  F:	sound/pci/cs5535audio/
>  
> +CSI DRIVERS FOR ALLWINNER V3s
> +M:	Yong Deng <yong.deng@magewell.com>
> +L:	linux-media at vger.kernel.org
> +T:	git git://linuxtv.org/media_tree.git
> +S:	Maintained
> +F:	drivers/media/platform/sun6i-csi/
> +F:	Documentation/devicetree/bindings/media/sun6i-csi.txt
> +
>  CW1200 WLAN driver
>  M:	Solomon Peachy <pizza@shaftnet.org>
>  S:	Maintained

Please squash to the driver patch. Thanks.

-- 
Sakari Ailus
e-mail: sakari.ailus at iki.fi
