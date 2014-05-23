From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 23 May 2014 15:24:28 +0200
Subject: [PATCH 2/5] Documentation: dt-bindings: document the Armada 375
 USB cluster binding
In-Reply-To: <537F13B2.6070500@ti.com>
References: <1400257376-13251-1-git-send-email-gregory.clement@free-electrons.com>
 <1400257376-13251-2-git-send-email-gregory.clement@free-electrons.com>
 <537F13B2.6070500@ti.com>
Message-ID: <537F4C0C.1080901@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

On 23/05/2014 11:24, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Friday 16 May 2014 09:52 PM, Gregory CLEMENT wrote:
>> Armada 375 comes with an USB2 host and device controller and an USB3
>> controller. The USB cluster control register allows to manage common
>> features of both USB controllers. This commit adds the Device Tree
>> binding documentation for this piece of hardware.
> 
> Pls re-order so that the Documentation patch comes before the driver patch..

OK I will do it

>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>  .../bindings/phy/armada-375-usb-phy-cluster.txt      | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/phy/armada-375-usb-phy-cluster.txt
>>
>> diff --git a/Documentation/devicetree/bindings/phy/armada-375-usb-phy-cluster.txt b/Documentation/devicetree/bindings/phy/armada-375-usb-phy-cluster.txt
> 
> simpler file name? armada-phy?

I can remove the "cluster" part but not the 375, there are many SoCs
from Marvell called Armada, and some of then have nearly nothing in
common, so I prefer keep this name. If your intent is to have a file
with all the PHY binding related to an SoC family, then we should call it
mvebu-phy.


Thanks for your review,

Gregory



-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
