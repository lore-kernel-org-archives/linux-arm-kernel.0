From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 27 Mar 2013 12:54:09 -0700
Subject: [PATCH 7/9] ARM: OMAP4+: Move the CPU wakeup prepare code under
 smp_prepare_cpus()
In-Reply-To: <515342D2.2080409@ti.com> (Santosh Shilimkar's message of "Thu,
 28 Mar 2013 00:34:50 +0530")
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
 <1361373527-21695-8-git-send-email-santosh.shilimkar@ti.com>
 <878v587kco.fsf@linaro.org> <515342D2.2080409@ti.com>
Message-ID: <87txnw62la.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> On Thursday 28 March 2013 12:15 AM, Kevin Hilman wrote:
>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>> 
>>> Move the secondary CPU wakeup prepare code under smp_prepare_cpus(). 
>> 
>> Why?
>> 
> Because that code belongs to smp_prepare_cpus(). As I said
> in earlier patches, it was remainder of the pen release code
> which was borrowed from ARM code initially.

Sure, but that should be in the changelog.

Kevin
