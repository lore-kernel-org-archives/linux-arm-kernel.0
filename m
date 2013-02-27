From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 27 Feb 2013 13:38:41 +0100
Subject: [PATCH 3/9] USB: add devicetree helpers for determining dr_mode
 and phy_type
In-Reply-To: <20130227123230.GN8016@arwen.pp.htv.fi>
References: <1361968035-18644-1-git-send-email-mkl@pengutronix.de>
 <1361968035-18644-4-git-send-email-mkl@pengutronix.de>
 <20130227123230.GN8016@arwen.pp.htv.fi>
Message-ID: <512DFE51.4030806@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/27/2013 01:32 PM, Felipe Balbi wrote:
> On Wed, Feb 27, 2013 at 01:27:09PM +0100, Marc Kleine-Budde wrote:
>> From: Michael Grzeschik <m.grzeschik@pengutronix.de>
>>
>> This adds two little devicetree helper functions for determining the dr_mode
> 
> it looks to me that "mode" is enough. s/dr_mode/mode/

There already is that DT binding, we just created a helper function for
that.

git grep -e dr_mode\ *: linus/master Documentation/
linus/master:Documentation/devicetree/bindings/usb/fsl-usb.txt: - dr_mode : indicates the working mode for "fsl-usb2-dr" compatible
linus/master:Documentation/devicetree/bindings/usb/nvidia,tegra20-ehci.txt:  - dr_mode : dual role mode. Indicates the working mode for

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130227/37d8315b/attachment.sig>
