From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 11 May 2014 06:49:53 +0200
Subject: [PATCH v2 2/4] dt-bindings: add mtk-timer bindings
In-Reply-To: <1399772463-859-3-git-send-email-matthias.bgg@gmail.com>
References: <1399772463-859-1-git-send-email-matthias.bgg@gmail.com>
 <1399772463-859-3-git-send-email-matthias.bgg@gmail.com>
Message-ID: <20140511044953.GR7047@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 11, 2014 at 03:41:01AM +0200, Matthias Brugger wrote:
> Add binding documentation for the General Porpose Timer driver of
> the Mediatek SoCs.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  .../devicetree/bindings/timer/mediatek,mtk-timer.txt    | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> 
> diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> new file mode 100644
> index 0000000..a36eb0f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> @@ -0,0 +1,17 @@
> +Mediatek MT6598, MT6577 and MT6572 Timers
> +---------------------------------------
> +
> +Required properties:
> +- compatible: Should be "mediatek,mtk6589-timer"
> +- reg: Should contain location and length for timers register.
> +- clocks : phandle to the clock source, normaly a 13 MHz fixed system clock
> +		and a 32 KHz fixed RTC clock.

If you don't want to use clock names for this, you should put the
order that you require them to be.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140511/64aef178/attachment-0001.sig>
