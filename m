From: robh@kernel.org (Rob Herring)
Date: Wed, 20 Jun 2018 12:25:12 -0600
Subject: [PATCH v3 4/9] dt-bindings: display: add DT bindings for BOE
 HV070WSA-100 panel
In-Reply-To: <1529396370-18761-5-git-send-email-m.purski@samsung.com>
References: <1529396370-18761-1-git-send-email-m.purski@samsung.com>
 <CGME20180619082000eucas1p1c5cc2b526583c3fd5e9fc13656ed4858@eucas1p1.samsung.com>
 <1529396370-18761-5-git-send-email-m.purski@samsung.com>
Message-ID: <20180620182512.GA14562@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2018 at 10:19:25AM +0200, Maciej Purski wrote:
> From: Andrzej Hajda <a.hajda@samsung.com>
> 
> The patch adds bindings to BOE HV070-WSA WSVGA panel.
> Bindings are compatible with simple panel bindings.
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Maciej Purski <m.purski@samsung.com>
> ---
>  .../bindings/display/panel/boe,hv070wsa-100.txt    | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/boe,hv070wsa-100.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/boe,hv070wsa-100.txt b/Documentation/devicetree/bindings/display/panel/boe,hv070wsa-100.txt
> new file mode 100644
> index 0000000..9e8eea8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/boe,hv070wsa-100.txt
> @@ -0,0 +1,28 @@
> +BOE HV070WSA-100 7.01" WSVGA TFT LCD panel
> +
> +Required properties:
> +- compatible: should be "boe,hv070wsa-100"
> +- power-supply: regulator to provide the VCC supply voltage (3.3 volts)
> +- enable-gpio: GPIO pin to enable and disable panel (active high)

enable-gpios

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
