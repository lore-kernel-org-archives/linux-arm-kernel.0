From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 20 Jan 2017 16:19:11 +0530
Subject: [PATCH v4 01/14] devicetree: bindings: add bindings for ahci-da850
In-Reply-To: <1484832588-18413-2-git-send-email-bgolaszewski@baylibre.com>
References: <1484832588-18413-1-git-send-email-bgolaszewski@baylibre.com>
 <1484832588-18413-2-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <d691d8dc-fd94-13ca-7f77-6ecfb8443ea4@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 19 January 2017 06:59 PM, Bartosz Golaszewski wrote:
> Add DT bindings for the TI DA850 AHCI SATA controller.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  Documentation/devicetree/bindings/ata/ahci-da850.txt | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/ahci-da850.txt
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-da850.txt b/Documentation/devicetree/bindings/ata/ahci-da850.txt
> new file mode 100644
> index 0000000..fd90662
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/ahci-da850.txt
> @@ -0,0 +1,15 @@
> +Device tree binding for the TI DA850 AHCI SATA Controller
> +---------------------------------------------------------
> +
> +Required properties:
> +  - compatible: must be "ti,da850-ahci"
> +  - reg: physical base addresses and sizes of the controller's register areas
> +  - interrupts: interrupt specifier (refer to the interrupt binding)
> +
> +Example:
> +
> +	sata: ahci at 218000 {

Please fix the example too, when you fix Sergei's comment on 12/14

Thanks,
Sekhar
