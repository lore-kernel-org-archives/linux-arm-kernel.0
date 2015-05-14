From: ian.campbell@citrix.com (Ian Campbell)
Date: Thu, 14 May 2015 09:50:13 +0100
Subject: [PATCH] arm/mach-exynos: suspend: Don't try to initialize
 suspend/suspend on old DT
In-Reply-To: <555235FB.3040804@kernel.org>
References: <1431438307-25410-1-git-send-email-julien.grall@citrix.com>
 <555235FB.3040804@kernel.org>
Message-ID: <1431593413.13579.9.camel@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-05-13 at 02:18 +0900, Kukjin Kim wrote:
> On 05/12/15 22:45, Julien Grall wrote:
> > Since commit 8b283c0 "ARM: exynos4/5: convert pmu wakeup to stacked domains",
> > a suspend/resume is not supported on old DT.
[...]
> I'm fine on this, applied.

Thanks. Do you also plan to send it to Linus (or to whomeever you feed
things through) for 4.1-rc$NEXT?

Cheers,
Ian.
