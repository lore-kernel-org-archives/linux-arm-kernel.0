From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 4 Aug 2014 21:25:10 +0200
Subject: Formal license ambiguity in arch/arm/boot/dts/sun?i-a*.dts
In-Reply-To: <201408031959.27607.arnd@arndb.de>
References: <20140731192016.GA6869@excalibur.cnev.de>
 <20140803130430.GY3952@lukather> <201408031959.27607.arnd@arndb.de>
Message-ID: <20140804192510.GF3952@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 03, 2014 at 07:59:27PM +0200, Arnd Bergmann wrote:
> On Sunday 03 August 2014, Maxime Ripard wrote:
> > Thanks for reporting this.
> > 
> > From a quick grep, the issue is actually broader than just
> > Allwinner. At least the following platforms seem to do the same:
> >   - mvebu
> >   - axm5516
> >   - bcm
> >   - berlin
> >   - ea3250
> >   - ecx-2000
> >   - highbank
> >   - imx / mxs
> >   - lpc32xx
> >   - phy3250
> >   - picoxcell
> >   - shmobile
> >   - rockchip
> >   - socfpga
> >   - spear
> >   - ste
> >   - zynq
> > 
> > Would you mind sending a patch to fix all these?
> 
> I would actually prefer if we could migrate a lot of these files to BSD license,
> provided the original authors agree. We want the dtb blobs to be embeddable into
> boot loaders of any license.

Even though I'd be open to having my contributions to DTBs under the
BSD, is this really a thing?

I mean, for all I know, an OS/Bootloader would just parse a documented
binary file, and I don't see any derivative work there.

The same argument could be made for example for u-boot modifying a
DTB I guess.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140804/139c804a/attachment.sig>
