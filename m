From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 12 May 2014 16:34:52 +0200
Subject: [PATCHv5 05/20] Documentation: dt-bindings: update ehci-orion
 binding documentation
In-Reply-To: <1399832288-19899-6-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1399832288-19899-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1399832288-19899-6-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5370DC0C.60604@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan,

On 11/05/2014 20:17, Thomas Petazzoni wrote:
> This commit updates the Device Tree binding documentation of
> ehci-orion to take into account the fact that we can now optionally
> pass a clock and a PHY reference.

Would you agree to take this patch with the 4 first ones?

For this kind of change in the device tree the agreement was that it
can be directly taken by the maintainer of the subsystem. Indeed here
we don't introduce a new kind of device tree node, we just add a optional
resource already used in many place.

Thanks,

Gregory


> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/usb/ehci-orion.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/ehci-orion.txt b/Documentation/devicetree/bindings/usb/ehci-orion.txt
> index 6bc09ec..17c3bc8 100644
> --- a/Documentation/devicetree/bindings/usb/ehci-orion.txt
> +++ b/Documentation/devicetree/bindings/usb/ehci-orion.txt
> @@ -6,6 +6,11 @@ Required properties:
>    region.
>  - interrupts: The EHCI interrupt
>  
> +Optional properties:
> +- clocks: reference to the clock
> +- phys: reference to the USB PHY
> +- phy-names: name of the USB PHY, should be "usb"
> +
>  Example:
>  
>  	ehci at 50000 {
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
