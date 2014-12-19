From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 19 Dec 2014 12:03:28 -0500
Subject: [PATCH 00/27] ARM: mvebu: armada-*: Relicense the device tree
 under GPLv2+/X11
In-Reply-To: <54944DAC.1000709@free-electrons.com>
References: <1418657915-22775-1-git-send-email-gregory.clement@free-electrons.com>
 <54930BBC.4060602@free-electrons.com>
 <20141218191528.GY967@titan.lakedaemon.net>
 <549437DD.7040602@free-electrons.com>
 <20141219160230.GZ967@titan.lakedaemon.net>
 <54944DAC.1000709@free-electrons.com>
Message-ID: <20141219170328.GA967@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 19, 2014 at 05:09:16PM +0100, Gregory CLEMENT wrote:
> On 19/12/2014 17:02, Jason Cooper wrote:
> > On Fri, Dec 19, 2014 at 03:36:13PM +0100, Gregory CLEMENT wrote:
> >> On 18/12/2014 20:15, Jason Cooper wrote:
> >>> On Thu, Dec 18, 2014 at 06:15:40PM +0100, Gregory CLEMENT wrote:
> >>> ...
> >>>> Jason at the end it seems you didn't ack or nack the patches were you
> >>>> were CC. You expressed some concerns about the GPLv2+ move but I don't know
> >>>> if it is something that prevents you to give your acked-by.
> >>>
> >>> Oops.  :)  I figured my S-o-B when applying would be sufficient.  That
> >>> decision was before we decided on Andrew applying patches this time
> >>> around...
> >>>
> >>> For all my dts{i} contributions:
> >>>
> >>> Acked-by: Jason Cooper <jason@lakedaemon.net>
> >>
> >> Thanks :)
> >>
> >>>
> >>> Due to all the merge commits over time and whatnot, it's probably best
> >>> to put my Ack on all the patches in this series...
> >>
> >> OK no problem. By the way, I take care of collecting all the acked-by and
> >> once it will be done I will either sent the updated patch set with all the
> >> acked-by or maybe just I will create a branch to pull if it is easier to handle.
> > 
> > Ok, that'll be up to Andrew.
> > 
> > Once we have the last few stragglers, and assuming there are no more
> > NAKs, here's what I'd like to do:
> > 
> > Regrettably, we'll have to revert Simon's dts contributions.  I say
> 
> You missed the email he sent yesterday, finally Simon changed his mind
> and gave his acked-by.

Indeed, that was for the oneliner change in the armada-370-xp.dtsi file.
I got a bit ahead of myself, but I'm looking towards kirkwood, orion5x,
dove, which brings up:

18ba7e4fe51d ARM: Kirkwood: add DT support for d2 Network v2
2d4cd2cafaea ARM: Kirkwood: allow to use netxbig DTSI for d2net_v2 DTS
a96cc303e42a ARM: mvebu: update the SATA compatible string for Armada 370/XP
d3dde4df4483 ARM: Kirkwood: update Network Space Mini v2 description
98d4f2acb91a ARM: Kirkwood: DT board setup for CloudBox
4ea931e07d77 ARM: Kirkwood: fix ns2 gpios by converting to pinctrl
7f9871d9d30f ARM: kirkwood: DT board setup for Network Space Mini v2
ca7d94524ab3 ARM: kirkwood: DT board setup for Network Space Lite v2
ecee1e47ab42 ARM: kirkwood: DT board setup for Network Space v2 and parents

thx,

Jason.
