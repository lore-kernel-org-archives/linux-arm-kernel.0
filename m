From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 29 Sep 2015 17:49:04 +0300
Subject: [PATCH v9 2/5] dt-bindings: Add a binding for Mediatek xHCI host
 controller
In-Reply-To: <1443495698-32233-3-git-send-email-chunfeng.yun@mediatek.com>
References: <1443495698-32233-1-git-send-email-chunfeng.yun@mediatek.com>
 <1443495698-32233-3-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <560AA4E0.3030705@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/29/2015 06:01 AM, Chunfeng Yun wrote:

> add a DT binding documentation of xHCI host controller for the
> MT8173 SoC from Mediatek.
>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>   .../devicetree/bindings/usb/mt8173-xhci.txt        | 52 ++++++++++++++++++++++
>   1 file changed, 52 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/usb/mt8173-xhci.txt
>
> diff --git a/Documentation/devicetree/bindings/usb/mt8173-xhci.txt b/Documentation/devicetree/bindings/usb/mt8173-xhci.txt
> new file mode 100644
> index 0000000..0c96273
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/mt8173-xhci.txt
> @@ -0,0 +1,52 @@
[...]
> +
> +Example:
> +usb30: usb at 11270000 {
[...]
> +	status = "okay";

    This line is not needed.

[...]

MBR, Sergei
