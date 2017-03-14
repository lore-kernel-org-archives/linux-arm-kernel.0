From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 14 Mar 2017 12:00:52 +0300
Subject: [PATCH 3/4] ARM: dts: dm8168-evm: add SATA node
In-Reply-To: <1489423399-3824-4-git-send-email-bgolaszewski@baylibre.com>
References: <1489423399-3824-1-git-send-email-bgolaszewski@baylibre.com>
 <1489423399-3824-4-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <27f977e7-fbd7-8136-5420-f93875a5582b@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/13/2017 7:43 PM, Bartosz Golaszewski wrote:

> Add the SATA controller node to the dm8168-evm device tree.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
[...]
> diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
> index 276211e..6131081 100644
> --- a/arch/arm/boot/dts/dm816x.dtsi
> +++ b/arch/arm/boot/dts/dm816x.dtsi
> @@ -293,6 +293,13 @@
>  			phy-handle = <&phy1>;
>  		};
>
> +		sata: sata at 4a140000 {
> +			compatible = "ti,dm816-ahci";
> +			reg = <0x4a140000 0xffff>;

    Again, 0x10000 for the size.

[...]

MBR, Sergei
