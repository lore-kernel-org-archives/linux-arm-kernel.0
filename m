From: horms@verge.net.au (Simon Horman)
Date: Mon, 25 Apr 2016 10:23:28 +1000
Subject: [GIT PULL] Renesas ARM Based SoC R-Car SYSC Updates for v4.7
In-Reply-To: <4901266.5hHvo6PbjV@wuerfel>
References: <cover.1461210185.git.horms+renesas@verge.net.au>
 <4901266.5hHvo6PbjV@wuerfel>
Message-ID: <20160425002328.GB30009@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 24, 2016 at 11:40:47PM +0200, Arnd Bergmann wrote:
> On Thursday 21 April 2016 13:44:48 Simon Horman wrote:
> > Renesas ARM Based SoC R-Car SYSC Updates for v4.7
> > 
> > * Add DT bindings for the R-Car System Controller.
> >   An implementation is intended to follow.
> > 
> 
> This seems to best fit into next/dt, but we can also stick it into other
> branches if it's needed as a dependency.

Hi Arnd,

Unfortunately this is more complex than I expected when I prepared this
pull request though the pull request itself is still correct.

There are driver changes that seem to logically fit on top of this pull
request. Though strictly speaking I don't believe there are any hard
run-time dependencies.

Then there are DT changes to enable the new driver that have
hard run-time dependencies on the driver changes themselves.

I have queued things up as described above and you can see them in the
renesas-next-20160422v3-v4.6-rc1 tag of next branch of the renesas tree.

I am planning to send corresponding pull requests in the near future.
I would be very happy to hear any feedback you have before I take that
step.
