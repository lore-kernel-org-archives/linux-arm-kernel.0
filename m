From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 25 Oct 2016 09:18:08 +0200
Subject: [PATCH RESEND 1/2] dt: bindings: add allwinner,otg-routed
 property for phy-sun4i-usb
In-Reply-To: <20161025041139.46454-1-icenowy@aosc.xyz>
References: <20161025041139.46454-1-icenowy@aosc.xyz>
Message-ID: <20161025071808.ywsi7tko72wyxhqh@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 25, 2016 at 12:11:38PM +0800, Icenowy Zheng wrote:
> On some newer Allwinner SoCs (H3 or A64), the PHY0 can be either routed to
> the MUSB controller (which is an OTG controller) or the OHCI/EHCI pair
> (which is a Host-only controller, but more stable and easy to implement).
> 
> This property marks whether on a certain board which controller should be
> attached to the PHY.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Didn't Hans reject this already? Why are you resending it?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161025/027156a6/attachment.sig>
