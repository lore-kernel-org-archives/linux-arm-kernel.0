From: khilman@ti.com (Kevin Hilman)
Date: Tue, 06 Sep 2011 15:59:55 -0700
Subject: [PATCH v6 00/25] gpio/omap: driver cleanup and fixes
In-Reply-To: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Wed, 31 Aug 2011 19:12:16 +0530")
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <87ty8pz384.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tarun,

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> This series is continuation of cleanup of OMAP GPIO driver and fixes.
> The cleanup include getting rid of cpu_is_* checks wherever possible,
> use of gpio_bank list instead of static array, use of unique platform
> specific value associated data member to OMAP platforms to avoid
> cpu_is_* checks. The series also include PM runtime support.*

Thanks for your continued effort on this series.

> Baseline: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> Branch: master
> Commit: c6a389f  Linux 3.1-rc4 

This series was supposed to be based on my for_3.2/gpio-cleanup branch,
which removes MOD_REG_BIT among other things.

Please rebase onto that branch so these changes can be tested along with
changes already queued for v3.2.

Thanks,

Kevin
