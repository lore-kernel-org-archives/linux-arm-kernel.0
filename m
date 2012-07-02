From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 2 Jul 2012 21:06:56 +0000
Subject: [GIT PULL] prima2 GPIO support in pinmux
In-Reply-To: <CAGsJ_4xcJCdt=wjNt6pcH1uQg+uHcsScDDtQvgNVRtsosPi=kg@mail.gmail.com>
References: <CAGsJ_4xrk0w5aQy+ZSYZwQ3pW5My7dcHnDX57+985VTbdHXCzg@mail.gmail.com>
 <CAGsJ_4xcJCdt=wjNt6pcH1uQg+uHcsScDDtQvgNVRtsosPi=kg@mail.gmail.com>
Message-ID: <201207022106.57244.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 July 2012, Barry Song wrote:
> 
> Note this has been acked by Linus Walleij, he suggested to go through
> prima2 arm-soc.
> 

Ok, I've pulled this into a new next/pinctrl branch for now, we'll see if
there are other pinctrl changes going through arm-soc for 3.6, if not we can
fold it into the next/drivers branch.

I've added Linus' Acked-by to the merge changeset.

	Arnd
