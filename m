From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 4 Jul 2018 09:44:08 +0200
Subject: [linux-sunxi] ARM: dts: sun8i: h3: Enable dwmac-sun8i on the
 Beelink X2
In-Reply-To: <CAEKpxBmCLF8PMQ2h2qghfMEMktQYdDZEPaFRLvN8-uzDr0mi9g@mail.gmail.com>
References: <20180630062720.24225-1-codekipper@gmail.com>
 <20180703145020.hkct43ccbpteleht@flea>
 <CAEKpxBmCLF8PMQ2h2qghfMEMktQYdDZEPaFRLvN8-uzDr0mi9g@mail.gmail.com>
Message-ID: <20180704074408.sx4ek6lvbaiyj5ut@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 03, 2018 at 07:19:16PM +0200, Code Kipper wrote:
> On 3 July 2018 at 16:50, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > Hi,
> >
> > On Sat, Jun 30, 2018 at 08:27:20AM +0200, codekipper at gmail.com wrote:
> >> From: Marcus Cooper <codekipper@gmail.com>
> >>
> >> The enabling of the emac was reverted when stability issues were
> >> discovered.
> >
> > What stability issues exactly? Have they been fixed? If so, by which
> > commit?
> 
> They were fixed by 4904337fe34f (ARM: dts: sunxi: Restore EMAC changes
> (boards)) but this board was missed.

Please add that to the commit log, and what the issue was.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180704/98da5e68/attachment.sig>
