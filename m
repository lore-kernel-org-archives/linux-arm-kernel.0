From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 23 Sep 2016 22:22:14 +0200
Subject: Alignment issues with freescale FEC driver
In-Reply-To: <20160923183725.GC1041@n2100.armlinux.org.uk>
References: <troy.kisky@boundarydevices.com>
 <02afb707-65de-5101-a79b-355929c4e00b@nelint.com>
 <CANn89iLb+QJu+MYh859oAAjcLCsKRpBbzVf43yOdq+HJVtZDpQ@mail.gmail.com>
 <5ee28ee0-cf0c-bdab-1271-f17755365c13@nelint.com>
 <20160923173751.GA1041@n2100.armlinux.org.uk>
 <d0d6f333-c6fc-6572-0633-d7c2c29b8b3f@nelint.com>
 <20160923183725.GC1041@n2100.armlinux.org.uk>
Message-ID: <20160923202214.kvnmvkc7abi5oj23@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Fri, Sep 23, 2016 at 07:37:25PM +0100, Russell King - ARM Linux wrote:
> On Fri, Sep 23, 2016 at 11:26:18AM -0700, Eric Nelson wrote:
> > So the question is: should we just live with this and acknowledge a
> > performance penalty of bad alignment or do something about it?
> 
> Well, I've no interest in trying to do anything with the FEC driver
> anymore, as I'll just generate another big patch stack which won't
> make it into the kernel in a timely fashion - my last attempt at
> improving the FEC driver was dogged with conflicting changes and I
> gave up with it in the end.  I ended up spending a full cycle
> rebasing, re-testing, and re-evaluating their performance only to find
> that I'd missed the merge window again, and other conflicting changes
> got merged which meant that I had to start from the beginning again.

I'm not included in the set of people who are responsible to review and
merge fec patches, but I'd be surprised if you couldn't get an exclusive
lock for that driver. Something like: After 4.X-rc1 the fec isn't
touched any more until you got your series ready for the 4.X+1 merge
window. Of course some fixes might have to go in, but these hopefully
won't disturb much.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
