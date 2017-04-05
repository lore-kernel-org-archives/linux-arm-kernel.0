From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 5 Apr 2017 09:28:32 +0200
Subject: [linux-sunxi] [PATCH 02/11] arm64: allwinner: a64: add NMI
 controller on A64
In-Reply-To: <CAGb2v672Z2JedGF3n+8Hi78QG_hAxz0ZYXaCkw0GAkA3xEdKrA@mail.gmail.com>
References: <20170404180145.12897-1-icenowy@aosc.io>
 <20170404180145.12897-3-icenowy@aosc.io>
 <CAGb2v67BucT8=FTgem3AmSU9XJA7OHoTCq3t3wBzDWyuwzZqaA@mail.gmail.com>
 <20170405061137.n66ectbkl7a2fv5f@lukather>
 <CAGb2v672Z2JedGF3n+8Hi78QG_hAxz0ZYXaCkw0GAkA3xEdKrA@mail.gmail.com>
Message-ID: <20170405072832.qunhfngatebcgn4q@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 05, 2017 at 02:20:31PM +0800, Chen-Yu Tsai wrote:
> On Wed, Apr 5, 2017 at 2:11 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Wed, Apr 05, 2017 at 11:51:45AM +0800, Chen-Yu Tsai wrote:
> >> On Wed, Apr 5, 2017 at 2:01 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
> >> > Allwinner A64 SoC features a NMI controller, which is usually connected
> >> > to the AXP PMIC.
> >> >
> >> > Add support for it.
> >> >
> >> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >>
> >> This might not be the best representation of the R_INTC block. Though
> >> we'd need to change it for all SoCs if we want to be accurate. For now,
> >
> > What do you think would be a good representation?
> 
> My gut feeling is that this is the old INTC from sun4/5i.

Ah, that would make sense.

> It's supposed to be the interrupt controller for the embedded low
> power core. I've not done a thorough comparison though.

Do we have some documentation / code for this one?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170405/9409c9d9/attachment.sig>
