From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 May 2015 11:37:21 +0200
Subject: [PATCH soc] ARM: use ARM_SINGLE_ARMV7M for ARMv7-M platforms
In-Reply-To: <1890f941dfa59138442da3e80a6b492a@agner.ch>
References: <1432161344-1930-1-git-send-email-stefan@agner.ch>
 <20150521190400.GD24769@pengutronix.de>
 <1890f941dfa59138442da3e80a6b492a@agner.ch>
Message-ID: <8411283.ijzXxHBtEc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 May 2015 09:27:38 Stefan Agner wrote:
> On 2015-05-21 21:04, Uwe Kleine-K?nig wrote:
> > On Thu, May 21, 2015 at 07:00:02PM +0200, Joachim Eastwood wrote:
> >> Hi Stefan,
> >>
> >> On 21 May 2015 at 00:35, Stefan Agner <stefan@agner.ch> wrote:
> >> > Use the new config symbol ARM_SINGLE_ARMV7M which groups config
> >> > symbols used by modern ARMv7-M platforms. This allows supporting
> >> > multiple ARMv7-M platforms in one kernel image. However, a common
> >> > kernel image requires the combined platforms to share the same
> >> > main memory layout to be bootable.
> >> >
> >> > Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> >> > Signed-off-by: Stefan Agner <stefan@agner.ch>
> >>
> >> You should have your sign-off on the top and not Uwe's ack.
> > I don't agree. IMHO the most sensible thing is to sign off (i.e. put
> > your sob line below) all the things that come from you. So it's
> > 
> >       Signed-off-by: author
> >       Acked-by: someone
> >       Signed-off-by: forwarder
> >       Signed-off-by: maintainer
> > 
> > if someone already acked before forwarder sent out the mail. If the ack
> > is between forwarder and maintainer it was the latter who added the Ack.
> > I'm not sure it's formalized this way, but like that it makes most sense
> > to me and I seem to recall having read somewhere that the footers are
> > supposed to tell something about the order of people involved.
> > 
> > So Stefan did it exactly as i would have done it.
> 
> Hm, never give much thoughts about that order, its quite development
> process driven here: I use git format-patch with --signoff. When I send
> out v1, and get a Ack or Review, I add that to my commit. Hence, when I
> send v2 of the patch, my sob line ends up below the Ack (that is what
> happened in that case). If its the last revision, and the patch gets
> picked up, the forwarder/maintainer will add the Ack and then it would
> land after my sob...

I think it's not very important either way. The order that Uwe suggested
is what we tend to end up with when everyone just adds additional tags
on the bottom, but I also see the acks added elsewhere.

The order for the signed-off-by lines is more important though, as it
documents the patch flow.

	Arnd
