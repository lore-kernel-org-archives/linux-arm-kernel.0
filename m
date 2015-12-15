From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 15 Dec 2015 16:22:20 +0300
Subject: [PATCH v3 1/4] ARM: dts: dra7: Add dt node for the sycon pcie
In-Reply-To: <1450172346-11890-2-git-send-email-kishon@ti.com>
References: <1450172346-11890-1-git-send-email-kishon@ti.com>
 <1450172346-11890-2-git-send-email-kishon@ti.com>
Message-ID: <5670140C.7010906@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 12/15/2015 12:39 PM, Kishon Vijay Abraham I wrote:

> Add new device tree node for the control module register space where
> PCIe registers are present.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>   arch/arm/boot/dts/dra7.dtsi |    5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index fe99231..e38f63f 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -155,6 +155,11 @@
>   					compatible = "syscon";
>   					reg = <0x1c04 0x0020>;
>   				};
> +
> +				scm_conf_pcie: tisyscon at 1c24 {

    Please use the generic node names as the ePAPR standard says.

[...]

MBR, Sergei
