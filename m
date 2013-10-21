From: mbizon@freebox.fr (Maxime Bizon)
Date: Mon, 21 Oct 2013 16:57:20 +0200
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131021091555.GB21518@ulmo.nvidia.com>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131020220839.GT2443@sirena.org.uk> <5264576F.6050307@wwwdotorg.org>
 <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
 <20131021091555.GB21518@ulmo.nvidia.com>
Message-ID: <1382367440.18145.28.camel@sakura.staff.proxad.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Mon, 2013-10-21 at 11:15 +0200, Thierry Reding wrote:

> A stable ABI means there's about zero chance of redesigning something
> after it's been merged. Unless we want to live with having to support
> several DT bindings in a driver.
> 
That will happen for sure, and it will suffer from lack of testing of
"old" bindings, like every uncommon combinations supported by the kernel
today (think 32b userspace over 64b kernel).

Solution: always use latest DT shipped with kernel. 

> impossible to take into account every possible detail up front simply
> because we're all only human and because some things just might change
> over time. I'm fairly sure that Linux wouldn't be where it is today if
> we didn't have that flexibility.

Also, as you said in another mail, new roadblocks have appeared to reach
mainline, you now have to convince DT maintainers that your DT bindings
are correct / future proof.

IMO this will cause even more un-mainlined SOCs/boards, with the added
difficulty to integrate the existing proprietary bindings if someone
wants to mainline later.


-- 
Maxime
