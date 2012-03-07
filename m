From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Mar 2012 21:38:04 +0000
Subject: [GIT PULL] One more sched_clock() patch
In-Reply-To: <4F57D3E7.6020605@codeaurora.org>
References: <322c288d3ad6aecc8014e0a3582c8527@localhost>
 <4F57D3E7.6020605@codeaurora.org>
Message-ID: <20120307213804.GG18787@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2012 at 01:32:23PM -0800, Stephen Boyd wrote:
> On 02/27/12 00:44, Marc Zyngier wrote:
> > Russell,
> >
> > Could you please pull from my sched_clock-for-rmk branch again?
> > It contains a single additional patch. courtesy of Stephen Boyd, that
> > contains support for sched_clock() on msm. The rest of the branch is
> > unchanged.
> 
> Has this been pulled? I don't see this showing up in linux-next as of
> 20120307.

Probably not yet, because I really don't like seeing a trickle of "some
more to fix" pull request followed by "oh another one to fix" pull
request, especially when they get pulled into devel-stable.

I'm waiting a bit to see if there's any more on their way. ;)
