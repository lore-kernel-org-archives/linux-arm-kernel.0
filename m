From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Tue, 22 Jul 2014 11:06:54 +0200
Subject: [RESEND PATCH 1/1] ARM: DT: STi: STiH416: Add DT node for ST's
 SATA device
In-Reply-To: <1405931573-12407-1-git-send-email-lee.jones@linaro.org>
References: <1405931573-12407-1-git-send-email-lee.jones@linaro.org>
Message-ID: <53CE29AE.3040505@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On 07/21/2014 10:32 AM, Lee Jones wrote:
> Cc: devicetree at vger.kernel.org
> Acked-by: Alexandre Torgue <alexandre.torgue@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   Documentation/devicetree/bindings/ata/ahci-st.txt |  2 +-
>   arch/arm/boot/dts/stih416-b2020.dts               |  4 ++++
>   arch/arm/boot/dts/stih416-b2020e.dts              |  4 ++++
>   arch/arm/boot/dts/stih416.dtsi                    | 16 ++++++++++++++++
>   4 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/ata/ahci-st.txt b/Documentation/devicetree/bindings/ata/ahci-st.txt
> index 0574a77..9883542 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-st.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-st.txt
> @@ -21,7 +21,7 @@ Example:
>   		reg             = <0xfe380000 0x1000>;
>   		interrupts      = <GIC_SPI 157 IRQ_TYPE_NONE>;
>   		interrupt-names = "hostc";
> -		phys	        = <&miphy365x_phy MIPHY_PORT_0 MIPHY_TYPE_SATA>;
> +		phys	        = <&phy_port0 MIPHY_TYPE_SATA>;
>   		phy-names       = "ahci_phy";
>   		resets	        = <&powerdown STIH416_SATA0_POWERDOWN>,
>   				  <&softreset STIH416_SATA0_SOFTRESET>;

Patch does not apply because this file does not exist in my tree.
Shouldn't be in a separate patch?

Regards,
Maxime
