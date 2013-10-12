From: marex@denx.de (Marek Vasut)
Date: Sat, 12 Oct 2013 11:47:06 +0200
Subject: [PATCH 11/12] usb: phy-mxs: update binding for adding disconnect
 line property
In-Reply-To: <1381568986-19802-12-git-send-email-peter.chen@freescale.com>
References: <1381568986-19802-1-git-send-email-peter.chen@freescale.com>
 <1381568986-19802-12-git-send-email-peter.chen@freescale.com>
Message-ID: <201310121147.07217.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Peter Chen,

> This property is used to disconnect line between USB PHY and
> USB controller.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  Documentation/devicetree/bindings/usb/mxs-phy.txt |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/mxs-phy.txt
> b/Documentation/devicetree/bindings/usb/mxs-phy.txt index 1a9bd85..099b0bb
> 100644
> --- a/Documentation/devicetree/bindings/usb/mxs-phy.txt
> +++ b/Documentation/devicetree/bindings/usb/mxs-phy.txt
> @@ -5,6 +5,9 @@ Required properties:
>  - reg: Should contain registers location and length
>  - interrupts: Should contain phy interrupt
>  - fsl,anatop: phandle for anatop register
> +- disconnect_line_without_vbus: needs to disconnect
> +connection between USB PHY and controller, it can avoid
> +unexpected wakeup interrupt when the PHY is out of power

Uh oh, this might needs some rewording. I didn't understand the reason for this 
prop before I checked the 12/12 patch.

Best regards,
Marek Vasut
