From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 4 Mar 2015 21:39:36 +0100
Subject: [PATCH] ARM: dts: sun7i: Add dts file for Wexler TAB7200
In-Reply-To: <20150304232615.3a91de393b12c0e38ee93b67@gmail.com>
References: <1425456947-4152-1-git-send-email-mamlinav@gmail.com>
 <20150304201819.GQ4911@lukather>
 <20150304232615.3a91de393b12c0e38ee93b67@gmail.com>
Message-ID: <20150304203936.GS4911@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 04, 2015 at 11:26:15PM +0300, Aleksei Mamlin wrote:
> On Wed, 4 Mar 2015 21:18:19 +0100
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > On Wed, Mar 04, 2015 at 11:15:47AM +0300, Aleksei Mamlin wrote:
> > > This patch add support for Wexler TAB7200 tablet.
> > > 
> > > The Wexler TAB7200 is a A20 based tablet with 7 inch display(800x480),
> > > capacitive touchscreen(5 fingers), 1G RAM, 4G NAND, micro SD card slot,
> > > mini HDMI port, 3.5mm audio plug, 1 USB OTG port and 1 USB 2.0 port.
> > > 
> > > Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
> > > ---
> > >  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
> > >  arch/arm/boot/dts/Makefile                         |   3 +-
> > >  arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts     | 185 +++++++++++++++++++++
> > >  3 files changed, 188 insertions(+), 1 deletion(-)
> > >  create mode 100644 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
> > > 
> > > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > > index 389ca13..eb67da4 100644
> > > --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > > +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > > @@ -189,6 +189,7 @@ variscite	Variscite Ltd.
> > >  via	VIA Technologies, Inc.
> > >  virtio	Virtual I/O Device Specification, developed by the OASIS consortium
> > >  voipac	Voipac Technologies s.r.o.
> > > +wexler	AVIRSA Electronics
> > 
> > Why a different name?
> 
> WEXLER trademark owned by AVIRSA Electronics, a member of the diversified holding AVIRSA.

It's not really an issue. There's a lot of different vendor owned by
the same companies in that file. And the fact that you named it wexler
in the first place proves that wexler is more known than avirsa.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150304/3fcd0a86/attachment.sig>
