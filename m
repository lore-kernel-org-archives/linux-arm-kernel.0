From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 26 Nov 2013 16:01:05 +0530
Subject: [PATCH v3 7/9] phy: add Broadcom Kona USB2 PHY DT binding
In-Reply-To: <1385403367-18144-8-git-send-email-matt.porter@linaro.org>
References: <1385403367-18144-1-git-send-email-matt.porter@linaro.org>
 <1385403367-18144-8-git-send-email-matt.porter@linaro.org>
Message-ID: <52947869.4040101@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 25 November 2013 11:46 PM, Matt Porter wrote:
> Add a binding that describes the Broadcom Kona USB2 PHY found
> on the BCM281xx family of SoCs.
> 
> Signed-off-by: Matt Porter <matt.porter@linaro.org>
> ---
>  .../devicetree/bindings/phy/bcm-kona-usb2-phy.txt         | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/bcm-kona-usb2-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/bcm-kona-usb2-phy.txt b/Documentation/devicetree/bindings/phy/bcm-kona-usb2-phy.txt
> new file mode 100644
> index 0000000..3dc8b3d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/bcm-kona-usb2-phy.txt

you should name this bcm-phy. Then you can add binding info of all (future) PHY
IP from broadcom here.

other than that this looks fine..
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

Thanks
Kishon
