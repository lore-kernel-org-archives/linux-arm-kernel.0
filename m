From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Tue, 29 Nov 2016 18:04:06 +0300
Subject: [PATCH] clocksource/arm_global_timer: reconfigure clockevents
 after cpufreq change
In-Reply-To: <54233c9e-d136-4b85-b2db-bf8658a164e7@arm.com>
References: <1480421716-30782-1-git-send-email-al.kochet@gmail.com>
 <1480421716-30782-2-git-send-email-al.kochet@gmail.com>
 <alpine.DEB.2.20.1611291432290.4358@nanos>
 <763a77c2-3d19-8d20-88df-27f0b8b80b8b@arm.com>
 <alpine.DEB.2.20.1611291529520.4358@nanos>
 <54233c9e-d136-4b85-b2db-bf8658a164e7@arm.com>
Message-ID: <51F052D4-7A19-40FE-8EC2-CE33684383A4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> 29 ????. 2016 ?., ? 17:51, Marc Zyngier <marc.zyngier@arm.com> ???????(?):
> 
> That'd be my preferred course of action. I've located some documentation
> over there [1], and page 1126 seems to indicate a profusion of
> additional timers, some of which are in an always-on domain. Seems like
> a much better use of someone's time...

Thank you very much :)
And thank you for great explanation of core problem.

In general, I no longer insist on the inclusion the patch in the kernel.
Thank you guys for the help.

Alexander.
