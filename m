From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 6 Mar 2014 22:20:59 +0100
Subject: [PATCH 0/4] ARM: mvebu: Device Tree updates for Armada XP boards
In-Reply-To: <20140306200543.GG1872@titan.lakedaemon.net>
References: <1393951022-18114-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140306200543.GG1872@titan.lakedaemon.net>
Message-ID: <20140306222059.3f22a3c3@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Thu, 6 Mar 2014 15:05:43 -0500, Jason Cooper wrote:

> Whole series applied to mvebu/dt.
> 
> fyi - we only have one more day of -next (tonight, 7pm US East Coast
> time) before -rc6 drops.
> 
> I'm comfortable sending a lightly tested mvebu/dt pull request with all
> the stuff submitted in the last couple days, but I fear there isn't
> enough testing time before arm-soc stops taking pull requests.
> 
> I'm particularly concerned about the watchdog changes and the coherency
> fabric changes.  I'll take those in when ready, and send pull requests
> when appropriate, but that will most likely fall after the cutoff.
> Which means those changes will carry over to v3.16...

I'll let Ezequiel speak for the watchdog stuff.

For the coherency fabric stuff, our plan was clearly to get it merged
on 3.16, not in 3.15. I'm sending it right now because we will have
other things (such as SMP support) to stack on top of it for 3.16. IOW:
no problems with having this only in 3.16. Of course, if you feel
comfortable about having it in 3.15, then that would be great, but it
is clearly not mandatory.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
