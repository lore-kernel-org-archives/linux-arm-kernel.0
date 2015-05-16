From: kgene@kernel.org (Kukjin Kim)
Date: Sat, 16 May 2015 12:45:30 +0900
Subject: [PATCH] arm/mach-exynos: suspend: Don't try to
 initializesuspend/suspend on old DT
In-Reply-To: <1431593413.13579.9.camel@citrix.com>
References: <1431438307-25410-1-git-send-email-julien.grall@citrix.com>
 <555235FB.3040804@kernel.org> <1431593413.13579.9.camel@citrix.com>
Message-ID: <5556BD5A.5010701@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/14/15 17:50, Ian Campbell wrote:
> On Wed, 2015-05-13 at 02:18 +0900, Kukjin Kim wrote:
>> On 05/12/15 22:45, Julien Grall wrote:
>>> Since commit 8b283c0 "ARM: exynos4/5: convert pmu wakeup to stacked domains",
>>> a suspend/resume is not supported on old DT.
> [...]
>> I'm fine on this, applied.
> 
> Thanks. Do you also plan to send it to Linus (or to whomeever you feed
> things through) for 4.1-rc$NEXT?
> 
Already it has been sent to Linus via arm-soc. I think, it should be
fine after v4.1-rc4?

- Kukjin
