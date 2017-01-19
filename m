From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 19 Jan 2017 20:45:09 +0300
Subject: [PATCH v4 12/14] ARM: dts: da850: add the SATA node
In-Reply-To: <1484832588-18413-13-git-send-email-bgolaszewski@baylibre.com>
References: <1484832588-18413-1-git-send-email-bgolaszewski@baylibre.com>
 <1484832588-18413-13-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <19a40d79-cc55-55c1-2e5a-c133dcef2f4a@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/19/2017 04:29 PM, Bartosz Golaszewski wrote:

> Add the SATA node to the da850 device tree.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/boot/dts/da850.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index 104155d..e9bf30e 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -403,6 +403,12 @@
>  			phy-names = "usb-phy";
>  			status = "disabled";
>  		};
> +		sata: ahci at 218000 {

    No, according to devicetree.org the node name should be "sata at 218000" and 
the label can be whatever you want.

[...]

MBR, Sergei
