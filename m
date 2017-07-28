From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 28 Jul 2017 18:03:53 +0200
Subject: [PATCH v2 2/3] dt-bindings: media: Add Allwinner V3s Camera
 Sensor Interface (CSI)
In-Reply-To: <1501131697-1359-3-git-send-email-yong.deng@magewell.com>
References: <1501131697-1359-1-git-send-email-yong.deng@magewell.com>
 <1501131697-1359-3-git-send-email-yong.deng@magewell.com>
Message-ID: <20170728160353.gqb2f47v6ujozvxz@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 27, 2017 at 01:01:36PM +0800, Yong Deng wrote:
> Add binding documentation for Allwinner V3s CSI.
> 
> Signed-off-by: Yong Deng <yong.deng@magewell.com>
> ---
>  .../devicetree/bindings/media/sun6i-csi.txt        | 49 ++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/sun6i-csi.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/sun6i-csi.txt b/Documentation/devicetree/bindings/media/sun6i-csi.txt
> new file mode 100644
> index 0000000..f8d83f6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/sun6i-csi.txt
> @@ -0,0 +1,49 @@
> +Allwinner V3s Camera Sensor Interface
> +------------------------------
> +
> +Required properties:
> +  - compatible: value must be "allwinner,sun8i-v3s-csi"
> +  - reg: base address and size of the memory-mapped region.
> +  - interrupts: interrupt associated to this IP
> +  - clocks: phandles to the clocks feeding the CSI
> +    * ahb: the CSI interface clock

We've been bad at this, but we're trying to have the same clock name
here across all devices, and to use "bus" instead of "ahb".

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170728/585e318b/attachment.sig>
