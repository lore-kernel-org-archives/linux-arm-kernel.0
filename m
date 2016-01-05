From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 05 Jan 2016 11:12:22 +0100
Subject: [PATCH v4 5/6] mfd: dt-bindings: add device tree bindings for
 Hi3519 sysctrl
In-Reply-To: <1451439832-13927-6-git-send-email-xuejiancheng@huawei.com>
References: <1451439832-13927-1-git-send-email-xuejiancheng@huawei.com>
 <1451439832-13927-6-git-send-email-xuejiancheng@huawei.com>
Message-ID: <1451988742.3391.22.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 30.12.2015, 09:43 +0800 schrieb Jiancheng Xue:
> Add device tree bindings for Hi3519 system controller.
> 
> Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
> ---
>  Documentation/devicetree/bindings/mfd/hi3519.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/hi3519.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/hi3519.txt b/Documentation/devicetree/bindings/mfd/hi3519.txt
> new file mode 100644
> index 0000000..2536edc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/hi3519.txt
> @@ -0,0 +1,14 @@
> +* Hisilicon Hi3519 System Controller Block
> +
> +This bindings use the following binding:
> +Dcumentation/devicetree/bindings/clock/clock-bindings.txt

Typo: "Documentation"
- but I don't see the clock bindings being used here at all.
Maybe just drop this sentence?

> +
> +Required properties:
> +- compatible: "hisilicon,hi3519-sysctrl".
> +- reg: the register region of this block
> +
> +Examples:
> +sysctrl: system-controller at 12010000 {
> +	compatible = "hisilicon,hi3519-sysctrl", "syscon";
> +	reg = <0x12010000 0x1000>;
> +};

regards
Philipp
