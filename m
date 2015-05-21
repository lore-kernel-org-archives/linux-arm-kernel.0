From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 21 May 2015 21:04:00 +0200
Subject: [PATCH soc] ARM: use ARM_SINGLE_ARMV7M for ARMv7-M platforms
In-Reply-To: <CAGhQ9VxkGh_V0ctb1U7Y5UZ36qa-7ZPPW2xsg07m4SHhXmXeJQ@mail.gmail.com>
References: <1432161344-1930-1-git-send-email-stefan@agner.ch>
 <CAGhQ9VxkGh_V0ctb1U7Y5UZ36qa-7ZPPW2xsg07m4SHhXmXeJQ@mail.gmail.com>
Message-ID: <20150521190400.GD24769@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 21, 2015 at 07:00:02PM +0200, Joachim Eastwood wrote:
> Hi Stefan,
> 
> On 21 May 2015 at 00:35, Stefan Agner <stefan@agner.ch> wrote:
> > Use the new config symbol ARM_SINGLE_ARMV7M which groups config
> > symbols used by modern ARMv7-M platforms. This allows supporting
> > multiple ARMv7-M platforms in one kernel image. However, a common
> > kernel image requires the combined platforms to share the same
> > main memory layout to be bootable.
> >
> > Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > Signed-off-by: Stefan Agner <stefan@agner.ch>
> 
> You should have your sign-off on the top and not Uwe's ack.
I don't agree. IMHO the most sensible thing is to sign off (i.e. put
your sob line below) all the things that come from you. So it's

	Signed-off-by: author
	Acked-by: someone
	Signed-off-by: forwarder
	Signed-off-by: maintainer

if someone already acked before forwarder sent out the mail. If the ack
is between forwarder and maintainer it was the latter who added the Ack.
I'm not sure it's formalized this way, but like that it makes most sense
to me and I seem to recall having read somewhere that the footers are
supposed to tell something about the order of people involved.

So Stefan did it exactly as i would have done it.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
