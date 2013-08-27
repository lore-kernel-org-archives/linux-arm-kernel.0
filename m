From: b.brezillon@overkiz.com (boris brezillon)
Date: Tue, 27 Aug 2013 14:43:27 +0200
Subject: [PATCH v2] ARM: at91/dt: fix phy address in sama5xmb to match
 the reg property
In-Reply-To: <1377607313-21331-1-git-send-email-b.brezillon@overkiz.com>
References: <1377605096-20903-1-git-send-email-b.brezillon@overkiz.com>
 <1377607313-21331-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <521C9EEF.1010303@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for the noise, but the previous commit message was not clear enough.

On 27/08/2013 14:41, Boris BREZILLON wrote:
> Fix phy0 address to match the reg property defined in phy0 node.
>
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> Changes since v1:
>   - better commit message
>
>   arch/arm/boot/dts/sama5d3xmb.dtsi |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/sama5d3xmb.dtsi b/arch/arm/boot/dts/sama5d3xmb.dtsi
> index e9521d5..dba739b 100644
> --- a/arch/arm/boot/dts/sama5d3xmb.dtsi
> +++ b/arch/arm/boot/dts/sama5d3xmb.dtsi
> @@ -84,7 +84,7 @@
>   
>   				#address-cells = <1>;
>   				#size-cells = <0>;
> -				phy0: ethernet-phy at 0 {
> +				phy0: ethernet-phy at 1 {
>   					interrupt-parent = <&pioE>;
>   					interrupts = <30 IRQ_TYPE_EDGE_FALLING>;
>   					reg = <1>;
