From: khilman@ti.com (Kevin Hilman)
Date: Fri, 25 May 2012 17:08:29 -0700
Subject: [PATCH v2 0/4] OMAP4: CPUidle: Add coupled idle support
In-Reply-To: <1337585559-20250-1-git-send-email-santosh.shilimkar@ti.com>
 (Santosh Shilimkar's message of "Mon, 21 May 2012 13:02:35 +0530")
References: <1337585559-20250-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <874nr3hkhu.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> Kevin,
>
> Now Colin's v3 [1] is apearing in Len Brown's next branch, I have rebased
> OMAP4 support against it. I need to pick up couple of fixes [2] posted on
> top of v3 [1] version and arm-soc 'omap/cpuidle-cleanup' branch lined up
> for 3.5.

Great.

> This series adds the coupled cpuidle support for OMAP4 and also removes
> the hard dependency of off-lining CPU1 to trigger deeper CPU C-states.
> It has been build tested for all OMAP builds and functionally tested
> on OMAP4430 SDP.
>
> I have put together a branch with:
> 1) Len Brown's 'next'
> 	: git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux 
> 2) ARM-SOC 'omap/cpuidle-cleanup'
> 	: git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
> 3) Two couple_idle_fixes picked up from [2]
>
> And same is available:
>
> git://gitorious.org/omap-sw-develoment/linux-omap-dev.git
> for_3.5/omap4_couple_idle

Excellent, thanks for pulling this together with the dependencies.

Linus has now merged the arm-soc/pm branch containing the OMAP CPUidle
cleanup from Daniel.  Also, I just ping'd Len on the status of Colin's
fixes.

As soon as all the depenencies are queued/merged I'll rebase this
on the right mainline commit and get this queued up for v3.6.

Thanks for keeping on top of this,

Kevin
