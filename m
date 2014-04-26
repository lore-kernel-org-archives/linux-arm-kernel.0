From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 26 Apr 2014 20:36:38 +0400
Subject: [PATCH 07/10] ARM: dts: DRA7: Add DT node for DES IP
In-Reply-To: <1398466968-29506-8-git-send-email-joelf@ti.com>
References: <1398466968-29506-1-git-send-email-joelf@ti.com>
 <1398466968-29506-8-git-send-email-joelf@ti.com>
Message-ID: <535BE096.2060407@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 26-04-2014 3:02, Joel Fernandes wrote:

> DRA7xx SoCs have a DES3DES IP. Add DT data for the same.

> Signed-off-by: Joel Fernandes <joelf@ti.com>
> ---
>   arch/arm/boot/dts/dra7.dtsi |   11 +++++++++++
>   1 file changed, 11 insertions(+)

> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 1c0f8e1..0533b89 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -789,6 +789,17 @@
>   			dma-names = "tx0", "rx0";
>   			status = "disabled";
>   		};
> +
> +		des: des at 480a5000 {

    Shouldn't the node name be "crypto at 480a5000", according to the ePAPR standard?

WBR, Sergei
