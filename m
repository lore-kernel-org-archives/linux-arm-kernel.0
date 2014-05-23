From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 23 May 2014 14:54:02 +0530
Subject: [PATCH 2/5] Documentation: dt-bindings: document the Armada 375
 USB cluster binding
In-Reply-To: <1400257376-13251-2-git-send-email-gregory.clement@free-electrons.com>
References: <1400257376-13251-1-git-send-email-gregory.clement@free-electrons.com>
 <1400257376-13251-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <537F13B2.6070500@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Friday 16 May 2014 09:52 PM, Gregory CLEMENT wrote:
> Armada 375 comes with an USB2 host and device controller and an USB3
> controller. The USB cluster control register allows to manage common
> features of both USB controllers. This commit adds the Device Tree
> binding documentation for this piece of hardware.

Pls re-order so that the Documentation patch comes before the driver patch..
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  .../bindings/phy/armada-375-usb-phy-cluster.txt      | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/armada-375-usb-phy-cluster.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/armada-375-usb-phy-cluster.txt b/Documentation/devicetree/bindings/phy/armada-375-usb-phy-cluster.txt

simpler file name? armada-phy?

Thanks
Kishon
