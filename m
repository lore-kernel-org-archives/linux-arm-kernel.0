From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 20 Aug 2014 20:26:00 +0530
Subject: [PATCH 1/5] phy: miphy28lp: Add Device Tree bindings for the
 MiPHY28lp
In-Reply-To: <1407944075-8093-2-git-send-email-gabriel.fernandez@linaro.org>
References: <1407944075-8093-1-git-send-email-gabriel.fernandez@linaro.org>
 <1407944075-8093-2-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <53F4B700.1010302@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 13 August 2014 09:04 PM, Gabriel FERNANDEZ wrote:
> The MiPHY28lp is a Generic PHY which can serve various SATA or PCIe
> or USB3 devices.
> 
> Signed-off-by: alexandre torgue <alexandre.torgue@st.com>
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
> ---
>  .../devicetree/bindings/phy/phy-miphy28lp.txt      | 126 +++++++++++++++++++++
>  1 file changed, 126 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-miphy28lp.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-miphy28lp.txt b/Documentation/devicetree/bindings/phy/phy-miphy28lp.txt
> new file mode 100644
> index 0000000..6e57bd5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-miphy28lp.txt
> @@ -0,0 +1,126 @@
> +STMicroelectronics STi MIPHY28LP PHY binding
> +============================================
> +
> +This binding describes a miphy device that is used to control PHY hardware
> +for SATA, PCIe or USB3.
> +
> +Required properties (controller (parent) node):
> +- compatible	: Should be "st,miphy28lp-phy"
> +- st,syscfg     : Should be a phandle of the system configuration register group

		^^^
I think here you used space and in the rest of places used tabs.
