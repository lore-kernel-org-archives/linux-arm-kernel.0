From: tony@atomide.com (Tony Lindgren)
Date: Fri, 25 Oct 2013 07:31:03 -0700
Subject: [PATCH 0/2] ARM: OMAP: dmtimers improvements.
In-Reply-To: <448912EABC71F84BBCADFD3C67C4BE5291DD30@DBDE04.ent.ti.com>
References: <20131024065536.16889.49902.stgit@notabene.brown>
 <448912EABC71F84BBCADFD3C67C4BE5291DD30@DBDE04.ent.ti.com>
Message-ID: <20131025143103.GZ15154@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [131024 11:11]:
> Sorry for top posting .... Probably we should move the dmtimer to drivers/misc or create drivers/timer/
> This has been pending for quite some time now....
> 
> Tony, what you say ?

Yes that should be done and we should cc Thomas Gleixner to
see if he has any better ideas for some of those exported
functions. Things that can be done with hrtimer should be done
with hrtimer, but at least the coprocessor use of timers and
PWM need to use timers directly.

Regards,

Tony
