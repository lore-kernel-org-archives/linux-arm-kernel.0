From: khilman@ti.com (Kevin Hilman)
Date: Tue, 27 Sep 2011 07:27:19 -0700
Subject: [PATCH v7 REPOST 00/24] gpio/omap: driver cleanup and fixes
In-Reply-To: <1317082460-31706-1-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Tue, 27 Sep 2011 05:43:56 +0530")
References: <1317082460-31706-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <87vcse3vso.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> This series is continuation of cleanup of OMAP GPIO driver and fixes.
> The cleanup include getting rid of cpu_is_* checks wherever possible,
> use of gpio_bank list instead of static array, use of unique platform
> specific value associated data member to OMAP platforms to avoid
> cpu_is_* checks. The series also include PM runtime support.*
>
> Baseline: git://gitorious.org/khilman/linux-omap-pm.git
> Branch: for_3.2/gpio-cleanup
> Commit: 8323374

Is this functionally different than the branch you posted yesterday?

I replied to that saying it does not fix the PER retention problems on
n900, and giving a suggestion of how to test it.

Kevin
