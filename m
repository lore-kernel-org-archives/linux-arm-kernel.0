From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 10 Jul 2018 16:58:28 +0200
Subject: [PATCH v5 08/22] ARM: dts: sun4i-a10: Use system-control
 compatible
In-Reply-To: <CAGb2v65JP8fBvD6Sbexjg2cv5AXVufWxjMVuOPa7J1A9qQjZ2g@mail.gmail.com>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
 <20180710080114.31469-9-paul.kocialkowski@bootlin.com>
 <CAGb2v65JP8fBvD6Sbexjg2cv5AXVufWxjMVuOPa7J1A9qQjZ2g@mail.gmail.com>
Message-ID: <20180710145828.ndrsiyb3ngnnxjk6@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 10:52:39PM +0800, Chen-Yu Tsai wrote:
> On Tue, Jul 10, 2018 at 4:01 PM, Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
> 
> Subject prefix should be "ARM: dts: sun4i:"
> 
> We don't need the "a10" part since the A10 owns into this category
> all by itself.
> 
> Also, it doesn't say what the system control compatible is for.
> "Switch to new system control compatible string" would be slightly
> better.
> 
> > This switches the sun4i-a10 dtsi to use the new compatible for the
> > system-control block (previously named SRAM controller) instead of
> > the deprecated one.
> >
> > The phandle is also updated to reflect the fact that the controller
> 
> The label actually.

Node name, actually :)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180710/bb82b662/attachment-0001.sig>
