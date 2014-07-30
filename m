From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 30 Jul 2014 08:52:56 +0100
Subject: [GIT PULL v2] nommu fixes for 3.17-rc1
In-Reply-To: <20140730070610.GL6146@pengutronix.de>
References: <20140630144355.GH14781@pengutronix.de>
 <20140701094159.GM14781@pengutronix.de>
 <20140711073054.GI11056@pengutronix.de>
 <20140722074246.GA28538@pengutronix.de>
 <20140729223543.GF30282@n2100.arm.linux.org.uk>
 <20140730070610.GL6146@pengutronix.de>
Message-ID: <20140730075256.GG30282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 30, 2014 at 09:06:10AM +0200, Uwe Kleine-K?nig wrote:
> Hi Russell,
>...
> Mine was sent to rmk+linux at ..., but I assume that's just an alias for
> linux at ... and I noted to use the new address in the future.

It isn't, it's an alias for rmk at ...

> On Tue, Jul 29, 2014 at 11:35:43PM +0100, Russell King - ARM Linux wrote:
> > It is very difficult to sort out which messages that contain "GIT PULL"
> > are meant for me - especially when people put me in the To: field of
> > all sorts of random emails with very little thought.  Because of that
> > behaviour, which has recently spread to replies by various mailers too,
> > I no longer take any notice of which header field my email address
> > appears in any message.
> 
> You could make life easier for contributors (and maybe also yourself) by
> assuming that a mail that lists only you in To: was sent by someone
> who got the difference between To and Cc and put it into your linux+pull
> folder. Just a suggestion.

How about people making my life easier by following the Internet RFCs
when it comes to which addresses should be in To: and Cc: ?

Then I can follow the information which my mail client gives me - that
is, the marking of each message which indicates whether I'm listed in
the To: header or the Cc: header, or indeed not listed at all.

Right now, scanning my mailbox for messages with me in the To: header
leads to /lots/ of crap.  This is precisely why I stated a while back
that I want pull requests for me to pull to go to linux+pull at ...  I
can then get my mail client to filter the mailbox for messages addressed
"To:" that address, which then gives me all the pull requests that people
want me to action.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
