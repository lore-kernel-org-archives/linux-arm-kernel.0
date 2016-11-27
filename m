From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 28 Nov 2016 00:10:09 +0100
Subject: [PATCH 2/2] net: dsa: mv88e6xxx: Add 88E6176 device tree support
In-Reply-To: <e5d45b55-a4c1-3b5e-0bdc-a5e340b072d0@suse.de>
References: <1480280279-9552-1-git-send-email-afaerber@suse.de>
 <1480280279-9552-2-git-send-email-afaerber@suse.de>
 <20161127212709.GD13318@lunn.ch>
 <9500470d-09c3-3ecb-994b-3d108bffc99e@suse.de>
 <20161127220846.GH13318@lunn.ch>
 <e5d45b55-a4c1-3b5e-0bdc-a5e340b072d0@suse.de>
Message-ID: <20161127231009.GA17704@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Try to see it from my perspective: I see that some vf610 device I don't
> have (found via `git grep marvell,mv88e6` or so) uses
> "marvell,mv88e6085". I then assume it has that device on board. How
> would I know it doesn't? Same for the other boards you mention.
> 
> Unfortunately some of your replies are slightly cryptic. Had you simply
> replied 'please just use "marvell,mv88e6085" instead', it would've been
> much more clear what you want. (Same for extending the subject instead
> of just pointing to some FAQ.)

By reading the FAQ you have learnt more than me saying put the correct
tree in the subject line. By asking you to explain why you need a
compatible string, i'm trying to make you think, look at the code and
understand it. In the future, you might think and understand the code
before posting a patch, and then we all save time.

> So are you okay with patch 1/2 documenting the compatible? Then we could
> drop 2/2 and use "marvell,mv88e6176", "marvell,mv88e6085" instead of
> just the latter. Or would you rather drop both and keep the actual chip
> a comment?

A comment only please.

Thanks
	Andrew
