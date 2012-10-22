From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 22 Oct 2012 06:54:40 +0200
Subject: [RFC 00/11] Convert Kirkwood to pinctrl
In-Reply-To: <5084650F.9050208@gmail.com>
References: <1350745663-5277-1-git-send-email-andrew@lunn.ch>
 <20121021210902.4dbd3e09@skate> <20121021191634.GL21046@lunn.ch>
 <5084650F.9050208@gmail.com>
Message-ID: <20121022045440.GA27355@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >However, i _think_ Sebastian had a different opinion to your two
> >yes's. Maybe its just for Dove?
> >
> >I hope Sebastian will comment soon.
> 
> Andrew, Thomas,
> 
> we had long discussions about this some time ago. I agree to both
> of Thomas' "yes" above as you convinced me that this is the best
> way of merging plat-orion and mach-mvebu.

O.K, great.

> 
> Do you want to add dove pinctrl to your patch set? If yes, when
> do you want to post v1 of this RFC?

Maybe we should split this into three patchsets.

1) Enable pinctl and gpio for both Dove and Kirkwood
2) Convert all the kirkwood boards
3) Convert all the Dove boards.

The conversion of kirkwood could take some time, since i would like a
tested-by: for each board. I think you have all the current Dove
boards, so could test very quickly. So this split of patchsets should
not hold you up much.

I will post the first two patches in my current set today, so you can
extend it with Dove.

       Andrew
