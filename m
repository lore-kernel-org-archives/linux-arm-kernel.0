From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 2 Sep 2016 08:28:35 +0200
Subject: [PATCH 4/6] ARM: sunxi: Support the Nextthing GR8
In-Reply-To: <CAGb2v66CDdSJMN4STHug1bGU2fnRK=Y24kwKS_8EtD6PZg3T-A@mail.gmail.com>
References: <20160831081817.5191-1-maxime.ripard@free-electrons.com>
 <20160831081817.5191-5-maxime.ripard@free-electrons.com>
 <CAGb2v66CDdSJMN4STHug1bGU2fnRK=Y24kwKS_8EtD6PZg3T-A@mail.gmail.com>
Message-ID: <20160902062835.GA6313@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

On Wed, Aug 31, 2016 at 04:25:27PM +0800, Chen-Yu Tsai wrote:
> On Wed, Aug 31, 2016 at 4:18 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The GR8 is an SoC made by Nextthing Co, loosely based on the sun5i family.
> >
> > It has a number of new controllers compared to the A10s and A13 (SPDIF, I2S),
> > but some controllers missing too (Ethernet, less I2C, less UARTs).
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  Documentation/devicetree/bindings/arm/sunxi.txt | 1 +
> >  MAINTAINERS                                     | 1 +
> >  arch/arm/mach-sunxi/sunxi.c                     | 1 +
> 
> Please update Documentation/arm/sunxi/README as well.

I will.

> I don't suppose there's a datasheet available?

Not at the moment, unfortunately.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160902/f5ec23fa/attachment.sig>
