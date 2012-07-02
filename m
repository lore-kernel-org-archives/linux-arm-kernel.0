From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 2 Jul 2012 21:11:40 +0000
Subject: [GIT PULL] prima2 GPIO support in pinmux
In-Reply-To: <CAGsJ_4xcJCdt=wjNt6pcH1uQg+uHcsScDDtQvgNVRtsosPi=kg@mail.gmail.com>
References: <CAGsJ_4xrk0w5aQy+ZSYZwQ3pW5My7dcHnDX57+985VTbdHXCzg@mail.gmail.com>
 <CAGsJ_4xcJCdt=wjNt6pcH1uQg+uHcsScDDtQvgNVRtsosPi=kg@mail.gmail.com>
Message-ID: <201207022111.41110.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 July 2012, Barry Song wrote:
> Note this has been acked by Linus Walleij, he suggested to go through
> prima2 arm-soc.

One more thing: You should really make sure your pull requests are based
off -rc releases rather than some commit between two -rc versions.

In this case, I've already taken it before I noticed and the only change
after the -rc is Russell's ARM bug fixes, which is better than having
non-ARM changes in there as well.

	Arnd
