From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 21 May 2015 18:29:52 +0530
Subject: [PATCH 2/2] doc: dt: add documentation for nxp,
 lpc1850-usb-otg-phy
In-Reply-To: <1431797277-4906-3-git-send-email-manabian@gmail.com>
References: <1431797277-4906-1-git-send-email-manabian@gmail.com>
 <1431797277-4906-3-git-send-email-manabian@gmail.com>
Message-ID: <555DD6C8.7040804@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Saturday 16 May 2015 10:57 PM, Joachim Eastwood wrote:
> Add binding documentation for nxp,lpc1850-usb-otg-phy. This PHY

%s/nxp,lpc1850-usb-otg-phy/NXP LPC18xx/43xx USB OTG PHY
> can found on NXP LPC18xx and LPC43xx devices.

Fix $subject to something like 'dt_bindings: Add NXP LPC18xx/43xx USB OTG PHY 
bindings'
>
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> ---
>   .../bindings/phy/nxp,lpc1850-usb-otg-phy.txt          | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/phy/nxp,lpc1850-usb-otg-phy.txt
>
> diff --git a/Documentation/devicetree/bindings/phy/nxp,lpc1850-usb-otg-phy.txt b/Documentation/devicetree/bindings/phy/nxp,lpc1850-usb-otg-phy.txt
> new file mode 100644
> index 000000000000..3da60ca04a42
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/nxp,lpc1850-usb-otg-phy.txt

phy-lpc18xx-usb-otg.txt?

Thanks
Kishon
