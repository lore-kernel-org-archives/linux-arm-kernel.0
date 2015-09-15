From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 15 Sep 2015 09:54:00 +0200
Subject: [PATCH v7 1/3] can: Allwinner A10/A20 CAN Controller support -
 Devicetree bindings
In-Reply-To: <1442272632-20251-2-git-send-email-info@gerhard-bertelsmann.de>
References: <1442272632-20251-1-git-send-email-info@gerhard-bertelsmann.de>
 <1442272632-20251-2-git-send-email-info@gerhard-bertelsmann.de>
Message-ID: <20150915075400.GK4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Sep 15, 2015 at 01:17:10AM +0200, Gerhard Bertelsmann wrote:
> Devicetree bindings for Allwinner A10/A20 CAN
> 
> Signed-off-by: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
> ---
> 
>  .../devicetree/bindings/net/can/sun4i_can.txt      |  38 +
>  1 file changed, 38 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/sun4i_can.txt b/Documentation/devicetree/bindings/net/can/sun4i_can.txt
> new file mode 100644
> index 0000000..5819043
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/sun4i_can.txt
> @@ -0,0 +1,38 @@
> +Allwinner A10/A20 CAN controller Device Tree Bindings
> +-----------------------------------------------------
> +
> +Required properties:
> +- compatible: "allwinner,sun4ican"

A bit better, but still not the one I told you to use.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150915/f791cfe6/attachment.sig>
