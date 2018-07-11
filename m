From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 11 Jul 2018 11:08:42 +0200
Subject: [PATCH v5 11/22] ARM: sun5i: Add support for the C1 SRAM region
 with the SRAM controller
In-Reply-To: <CAGb2v65swXpLwAo3M9X=MJeVmUrjT=FPFZxp=eCzMrfopqHKjA@mail.gmail.com>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
 <20180710080114.31469-12-paul.kocialkowski@bootlin.com>
 <CAGb2v65swXpLwAo3M9X=MJeVmUrjT=FPFZxp=eCzMrfopqHKjA@mail.gmail.com>
Message-ID: <20180711090842.q3q3lvnuwj52nnjx@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 10:56:23PM +0800, Chen-Yu Tsai wrote:
> On Tue, Jul 10, 2018 at 4:01 PM, Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
> > From: Maxime Ripard <maxime.ripard@bootlin.com>
> >
> > This adds support for the C1 SRAM region (to be used with the SRAM
> > controller driver) for sun5i-based platforms. The region is shared
> > between the Video Engine and the CPU.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> 
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> 
> But again, see discussion about SRAM compatibles.

I've fixed the SRAM C size (which is 0xd0000 and not 0x80000) and
applied, thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180711/d585deb3/attachment.sig>
