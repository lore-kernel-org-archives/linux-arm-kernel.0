From: olof@lixom.net (Olof Johansson)
Date: Fri, 12 Apr 2013 23:50:56 -0700
Subject: [GIT PULL] Timer clean-ups for 3.10, Part 2
In-Reply-To: <201304112257.07645.arnd@arndb.de>
References: <516720B4.3000703@gmail.com>
 <201304112257.07645.arnd@arndb.de>
Message-ID: <20130413065056.GB14735@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 10:57:07PM +0200, Arnd Bergmann wrote:
> On Thursday 11 April 2013, Rob Herring wrote:
> > Olof, Arnd,
> > 
> > Please pull timer clean-ups for arch timer, sp804, and integrator-cp timers.
> > 
> > I've dropped the final patch which moved the sp804 and integrator timers
> > code to drivers/clocksource until the desired structure is worked out.
> > 
> > Simon, the fixes for shmobile were trivial. Please comment if you see
> > any issues.
> 
> Ok, nice!
> 
> There are various bits for which I'd like to see Russell's ACK before
> we send them Linuswards, but it all looks good to me.
> 
> I would put it into arm-soc tomorrow, and hopefully Haojian Zhuang is
> able to send an updated version of his hisilicon platform code based
> on top of this in time for the merge window. The patches are all
> reviewed but just waiting for the sp804 changes now, and since
> it's a new platform, I'm not worried about regressions.

I've pulled this in as a late/clksrc branch now, so that we keep it separate
from the other work in case Russell ends up having comments on it when he is
back online.

Also, I based the branch on samsung/mct and samsung/clk, since they had merge
conflicts. Kukjin, Rob, please confirm that I've resolved them properly.


-Olof
