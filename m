From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 14 Apr 2014 12:33:34 +0200
Subject: [PATCH 12/29] ARM: orion5x: add interrupt for Ethernet in Device
 Tree
In-Reply-To: <1397400006-4315-13-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-13-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <534BB97E.9050201@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/13/2014 04:39 PM, Thomas Petazzoni wrote:
> For some reason, the Ethernet interrupt was missing in the Orion5x
> Device Tree definition.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

> ---
>   arch/arm/boot/dts/orion5x.dtsi | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/orion5x.dtsi b/arch/arm/boot/dts/orion5x.dtsi
> index 31d46e6..ac2ec8f 100644
> --- a/arch/arm/boot/dts/orion5x.dtsi
> +++ b/arch/arm/boot/dts/orion5x.dtsi
> @@ -128,6 +128,7 @@
>   				ethernet-port at 0 {
>   					compatible = "marvell,orion-eth-port";
>   					reg = <0>;
> +					interrupts = <21>;
>   					/* overwrite MAC address in bootloader */
>   					local-mac-address = [00 00 00 00 00 00];
>   					/* set phy-handle property in board file */
>
