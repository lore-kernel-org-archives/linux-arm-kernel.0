From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 11 Jan 2016 05:48:46 +0000
Subject: [PATCH v5 5/6] mfd: dt-bindings: add device tree bindings for
 Hi3519 sysctrl
In-Reply-To: <1452219400-32478-6-git-send-email-xuejiancheng@huawei.com>
References: <1452219400-32478-1-git-send-email-xuejiancheng@huawei.com>
 <1452219400-32478-6-git-send-email-xuejiancheng@huawei.com>
Message-ID: <20160111054846.GD3331@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 08 Jan 2016, Jiancheng Xue wrote:

> Add device tree bindings for Hi3519 system controller.
> 
> Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
> ---
>  Documentation/devicetree/bindings/mfd/hi3519.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/hi3519.txt

I have this patch, but none of the others in the set, thus I am
lacking context.

> diff --git a/Documentation/devicetree/bindings/mfd/hi3519.txt b/Documentation/devicetree/bindings/mfd/hi3519.txt
> new file mode 100644
> index 0000000..115c5be
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/hi3519.txt
> @@ -0,0 +1,14 @@
> +* Hisilicon Hi3519 System Controller Block
> +
> +This bindings use the following binding:
> +Documentation/devicetree/bindings/mfd/syscon.txt
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

There is no requirement (nor want) for binding documents where the
given device is simply using highly generic bindings.  This just
amounts to churn.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
