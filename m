From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 6 Jan 2016 22:03:24 +0100
Subject: [RFC PATCH 5/5] arm64: Introduce Allwinner SoC config option
In-Reply-To: <12966735.VQfHhlD3ne@wuerfel>
References: <1450787267-26836-1-git-send-email-andre.przywara@arm.com>
 <1450787267-26836-6-git-send-email-andre.przywara@arm.com>
 <20160104112648.GD11722@lukather> <12966735.VQfHhlD3ne@wuerfel>
Message-ID: <20160106210324.GB9631@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, Jan 04, 2016 at 01:12:53PM +0100, Arnd Bergmann wrote:
> On Monday 04 January 2016 12:26:48 Maxime Ripard wrote:
> > Hi Andre, Arnd,
> > 
> > On Tue, Dec 22, 2015 at 12:27:47PM +0000, Andre Przywara wrote:
> > > To prepare for supporting the Allwinner A64 SoC, introduce a config
> > > option to allow compiling Allwinner (aka. sunxi) specific drivers
> > > for ARM64.
> > > This patch just defines the ARCH_SUNXI symbol to allow Allwinner
> > > specific drivers to be selected during kernel configuration.
> > > 
> > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > 
> > I'm ok taking this patch.
> > 
> > I'm not quite sure how the process works though with arm64. Should I
> > send a PR with this patch to Catalin, or does it go through the usual
> > arm-soc maintainers?
> 
> We usually take these through arm-soc. 

Ok.

> > We should also probably extend the MAINTAINERS entry, shouldn't we?
> > 
> 
> A lot of the arm64 changes get sent to arm-soc from random developers that
> are not in the MAINTAINERS file at the moment, and I'd like to reduce
> that, so please pick up whatever arm64 sunxi changes you see that look ok
> and send a separate pull request as you do for arm32. Sending patches
> separately is fine too, but I'd like to see them come from you to arm at kernel.org
> so I don't need to guess whether we should pick them up or not.
> 
> This time around, we have two arm64 branches, one for boot/dts and one
> combined for Kconfig and defconfig (MAINTAINERS can also go in there). We
> are still experimenting with that model though, and it may change in
> the future.

Understood. Thanks a lot!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160106/e8aec8cf/attachment.sig>
