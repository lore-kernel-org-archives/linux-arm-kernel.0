From: tony@atomide.com (Tony Lindgren)
Date: Wed, 12 Aug 2015 00:15:27 -0700
Subject: [RFC/PATCH-v4.2-rc6 1/5] Revert "ARM: 7655/1: smp_twd: make
 twd_local_timer_of_register() no-op for nosmp"
In-Reply-To: <1439242911-715-2-git-send-email-balbi@ti.com>
References: <1439242911-715-1-git-send-email-balbi@ti.com>
 <1439242911-715-2-git-send-email-balbi@ti.com>
Message-ID: <20150812071527.GP4215@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [150810 14:45]:
> This reverts commit 904464b91eca8c665acea033489225af02eeb75a.
> 
> The problem pointed out by commit 904464b91eca ("ARM: 7655/1:
> smp_twd: make twd_local_timer_of_register() no-op for nosmp")
> doesn't exist anymore.
> 
> We can safely boot with nosmp and the warning won't show up.
> 
> The other side benefit of this patch is that TWD has a chance
> to probe on single-core A9 systems such as AM437x which sport
> TWD.

Can you please upload this into Russell's patch tracking system
if no comments? Please also feel free to add:

Acked-by: Tony Lindgren <tony@atomide.com>
