From: horms@verge.net.au (Simon Horman)
Date: Tue, 12 Nov 2013 11:30:44 +0900
Subject: [PATCH/RFC] ARM: Rename ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY
In-Reply-To: <9547447.Oq0RhNMWv3@avalon>
References: <1383782061-7111-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <CANqRtoRDo6_VYhaq9KkSCo2TnhmwW-vFK99HuBS=umrC1_fD_g@mail.gmail.com>
 <20131108060803.GF9828@verge.net.au> <9547447.Oq0RhNMWv3@avalon>
Message-ID: <20131112023043.GF9863@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 09, 2013 at 01:34:31PM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Friday 08 November 2013 15:08:05 Simon Horman wrote:
> > On Thu, Nov 07, 2013 at 03:04:57PM +0900, Magnus Damm wrote:
> > > On Thu, Nov 7, 2013 at 8:54 AM, Laurent Pinchart wrote:
> > > > SH-Mobile platforms are transitioning from non-multiplatform to
> > > > multiplatform kernel. A new ARCH_SHMOBILE_MULTI configuration symbol has
> > > > been created to group all multiplatform-enabled SH-Mobile SoCs. The
> > > > existing ARCH_SHMOBILE configuration symbol groups SoCs that haven't
> > > > been converted yet.
> > > > 
> > > > This arrangement works fine for the arch/ code, but lots of drivers
> > > > needed on both ARCH_SHMOBILE and ARCH_SHMOBILE_MULTI depend on
> > > > ARCH_SHMOBILE only. In order to avoid changing them, rename
> > > > ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY, and create a new boolean
> > > > ARCH_SHMOBILE configuration symbol that is selected by both
> > > > ARCH_SHMOBILE_LEGACY and ARCH_SHMOBILE_MULTI.
> > > > 
> > > > Signed-off-by: Laurent Pinchart
> > > > <laurent.pinchart+renesas@ideasonboard.com>
> > > 
> > > Thanks, this looks good to me.
> > > 
> > > Acked-by: Magnus Damm <damm@opensource.se>
> > 
> > This seems reasonable to me.
> > I would pick it up now but it is marked as "RFC".
> > Please let me know if you wish me to pick it up.
> 
> I've sent a non-RFC series, please pick that one up.

Thanks, will do.
