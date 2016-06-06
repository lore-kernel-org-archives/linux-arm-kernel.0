From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 6 Jun 2016 11:36:00 -0700
Subject: [PATCH v4 3/7] binding: mdio-mux: Add DT binding doc for Broadcom
 MDIO bus multiplexer
In-Reply-To: <1465216900-11755-4-git-send-email-pramod.kumar@broadcom.com>
References: <1465216900-11755-1-git-send-email-pramod.kumar@broadcom.com>
 <1465216900-11755-4-git-send-email-pramod.kumar@broadcom.com>
Message-ID: <5755C290.2020704@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2016 05:41 AM, Pramod Kumar wrote:
> Add DT binding doc for Broadcom MDIO bus multiplexer driver.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>


> +for example:
> +		mdio_mux_iproc: mdio-mux at 6602023c {

I think Rob wanted you to drop the underscores here in favor of dashes,
there are more below, not critical imho.

> +			compatible = "brcm,mdio-mux-iproc";
> +			reg = <0x6602023c 0x14>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			mdio at 0 {
> +				reg = <0x0>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				pci_phy0: pci-phy at 0 {


-- 
Florian
