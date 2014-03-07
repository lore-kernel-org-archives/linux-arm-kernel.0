From: horms@verge.net.au (Simon Horman)
Date: Fri, 7 Mar 2014 11:38:42 +0900
Subject: [PATCH 01/03] ARM: shmobile: Remove legacy EMEV2 SoC support
In-Reply-To: <CANqRtoTKLjHvjFHNtz3Qr9Mm+1ZafqxQFr7NtgTHNLh+4L+_NA@mail.gmail.com>
References: <20140213082558.30630.93034.sendpatchset@w520>
 <20140213082608.30630.40000.sendpatchset@w520>
 <20140217032306.GH7772@verge.net.au>
 <20140218041643.GB32417@verge.net.au>
 <CANqRtoTKLjHvjFHNtz3Qr9Mm+1ZafqxQFr7NtgTHNLh+4L+_NA@mail.gmail.com>
Message-ID: <20140307023839.GJ11702@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 01:25:49PM +0900, Magnus Damm wrote:
> Hi Simon,
> 
> On Tue, Feb 18, 2014 at 1:16 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Mon, Feb 17, 2014 at 12:23:09PM +0900, Simon Horman wrote:
> >> On Thu, Feb 13, 2014 at 05:26:08PM +0900, Magnus Damm wrote:
> >> > From: Magnus Damm <damm@opensource.se>
> >> >
> >> > Get rid of legacy EMEV2 SoC code including the legacy clock
> >> > framework implementation. The multiplatform implementation
> >> > together with DT board support shall be used instead.
> >> >
> >> > Signed-off-by: Magnus Damm <damm@opensource.se>
> >>
> >> Thanks, I have queued this up.
> >
> > I have dropped this patch for now and plan to deffer it.
> > This is because although this is patch 1 of the series
> > it removes emev2_clock_init() which causes the build
> > of board-kzm9d-reference.c to fail without
> > "ARM: shmobile: Remove Lager DT reference legacy clock bits".
> >
> > My current thinking is that the best way to sequence this is to
> > queue up the board and defconfig changes for v3.15 but wait
> > for v3.16 to queue up the SoC changes. This avoids tedious
> > dependencies of SoC patches on board patches in the same release cycle.
> 
> Thanks, that's of course fine with me!

I have now queued this up for v3.16.
