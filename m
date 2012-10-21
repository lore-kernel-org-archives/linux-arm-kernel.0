From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 21 Oct 2012 21:16:34 +0200
Subject: [RFC 00/11] Convert Kirkwood to pinctrl
In-Reply-To: <20121021210902.4dbd3e09@skate>
References: <1350745663-5277-1-git-send-email-andrew@lunn.ch>
 <20121021210902.4dbd3e09@skate>
Message-ID: <20121021191634.GL21046@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 21, 2012 at 09:09:02PM +0200, Thomas Petazzoni wrote:
> Dear Andrew Lunn,
> 
> On Sat, 20 Oct 2012 17:07:32 +0200, Andrew Lunn wrote:
> 
> > This patchset converts all kirkwood DT boards to pinctrl.
> > It is an RFC for a number of reasons:
> 
> Thanks for doing this work!
> 
> > Do we want to enable the use of mvebu GPIO driver
> > outside of mach-mvebu?
> 
> Yes.
> 
> > Do we want to enable the use of mvebu pinctrl driver
> > outside of mach-mvebu?
> 
> Yes.
> 
> Generally speaking, I think it is a good idea for
> mach-{mvebu,kirkwood,dove,mv78xx0,orion5x} to share as much
> infrastructure code as possible.

Definitely.

However, i _think_ Sebastian had a different opinion to your two
yes's. Maybe its just for Dove?

I hope Sebastian will comment soon.

  Andrew
