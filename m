From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 11 Jul 2018 11:01:57 +0200
Subject: [linux-sunxi] [PATCH v5 09/22] ARM: dts: sun5i: Use
 most-qualified system control compatibles
In-Reply-To: <CAGb2v64HbpvJhy5KQOepc61nU7NECaWMPvhZ16dk5hJXiPBHxA@mail.gmail.com>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
 <20180710080114.31469-10-paul.kocialkowski@bootlin.com>
 <CAGb2v64HbpvJhy5KQOepc61nU7NECaWMPvhZ16dk5hJXiPBHxA@mail.gmail.com>
Message-ID: <20180711090157.bs435c4k6knb6bqv@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 10:53:44PM +0800, Chen-Yu Tsai wrote:
> On Tue, Jul 10, 2018 at 4:01 PM, Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
> > This switches the sun5i dtsi to use the most qualified compatibles for
> > the system-control block (previously named SRAM controller) as well as
> > the SRAM blocks. The sun4i-a10 compatibles are kept since these hardware
> > blocks are backward-compatible.
> 
> Not quite sure why they are backward-compatible. The A13 has less SRAM
> mapping controls than the A10.

I've applied this patch, and removed that compatible (and its mention
in the commit log).

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180711/f852be1d/attachment.sig>
