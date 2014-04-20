From: balbi@ti.com (Felipe Balbi)
Date: Sat, 19 Apr 2014 22:22:55 -0500
Subject: [PATCH 4/8] ARM: mvebu: Add USB3 UTMI support
In-Reply-To: <1397816563-9000-5-git-send-email-gregory.clement@free-electrons.com>
References: <1397816563-9000-1-git-send-email-gregory.clement@free-electrons.com>
 <1397816563-9000-5-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140420032255.GD26893@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Apr 18, 2014 at 12:22:39PM +0200, Gregory CLEMENT wrote:
> The usb3-utmi registers allow to configure the internal USB PHY of the
> Armada 380/385 SoCs. A small initialization is needed to be able to use
> the USB3 ports.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

looks like this should be a generic drivers/phy/phy-utmi.c driver

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140419/cfb16004/attachment.sig>
