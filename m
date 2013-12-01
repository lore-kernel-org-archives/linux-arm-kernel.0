From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 1 Dec 2013 18:34:54 -0500
Subject: [PATCHv2 0/4] ARM: mvebu/kirkwood: NETGEAR ReadyNAS .dts files
 cleanup
In-Reply-To: <87eh5wmanc.fsf@natisbad.org>
References: <cover.1385756371.git.arno@natisbad.org>
 <20131201221710.GB2879@titan.lakedaemon.net>
 <87eh5wmanc.fsf@natisbad.org>
Message-ID: <20131201233454.GE2879@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 02, 2013 at 12:09:11AM +0100, Arnaud Ebalard wrote:
> 
> Jason Cooper <jason@lakedaemon.net> writes:
> 
> >> Arnaud Ebalard (4):
> >>   ARM: kirkwood: NETGEAR ReadyNAS Duo v2 .dts cleanup
> >>   ARM: mvebu: NETGEAR ReadyNAS 102 .dts cleanup
> >>   ARM: mvebu: NETGEAR ReadyNAS 104 .dts cleanup
> >>   ARM: Fix whitespaces in NETGEAR ReadyNAS .dts files
> >> 
> >>  arch/arm/boot/dts/armada-370-netgear-rn102.dts     | 82 ++++++++++--------
> >>  arch/arm/boot/dts/armada-370-netgear-rn104.dts     | 68 +++++++--------
> >>  .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts  | 99 +++++++++++++---------
> >>  3 files changed, 141 insertions(+), 108 deletions(-)
> >
> > whole series applied to mvebu/dt.  There was a small conflict with
> > Sebastian's pinctrl work.  Please double check and let me know if
> > anything is amiss.
> 
> All three .dts files look as they should in your branch.

Great!

thx,

Jason.
