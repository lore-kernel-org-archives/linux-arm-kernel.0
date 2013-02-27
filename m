From: balbi@ti.com (Felipe Balbi)
Date: Wed, 27 Feb 2013 14:41:30 +0200
Subject: [PATCH 3/9] USB: add devicetree helpers for determining dr_mode
 and phy_type
In-Reply-To: <512DFE51.4030806@pengutronix.de>
References: <1361968035-18644-1-git-send-email-mkl@pengutronix.de>
 <1361968035-18644-4-git-send-email-mkl@pengutronix.de>
 <20130227123230.GN8016@arwen.pp.htv.fi>
 <512DFE51.4030806@pengutronix.de>
Message-ID: <20130227124130.GP8016@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 27, 2013 at 01:38:41PM +0100, Marc Kleine-Budde wrote:
> On 02/27/2013 01:32 PM, Felipe Balbi wrote:
> > On Wed, Feb 27, 2013 at 01:27:09PM +0100, Marc Kleine-Budde wrote:
> >> From: Michael Grzeschik <m.grzeschik@pengutronix.de>
> >>
> >> This adds two little devicetree helper functions for determining the dr_mode
> > 
> > it looks to me that "mode" is enough. s/dr_mode/mode/
> 
> There already is that DT binding, we just created a helper function for
> that.
> 
> git grep -e dr_mode\ *: linus/master Documentation/
> linus/master:Documentation/devicetree/bindings/usb/fsl-usb.txt: - dr_mode : indicates the working mode for "fsl-usb2-dr" compatible
> linus/master:Documentation/devicetree/bindings/usb/nvidia,tegra20-ehci.txt:  - dr_mode : dual role mode. Indicates the working mode for

fair enough, then there's nothing we can do :-p

I'll take it soonish.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130227/aa8cd7cc/attachment-0001.sig>
