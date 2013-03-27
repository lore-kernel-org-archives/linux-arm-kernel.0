From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 28 Mar 2013 02:20:27 +0530
Subject: [PATCH 7/9] ARM: OMAP4+: Move the CPU wakeup prepare code under
 smp_prepare_cpus()
In-Reply-To: <87txnw62la.fsf@linaro.org>
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
 <1361373527-21695-8-git-send-email-santosh.shilimkar@ti.com>
 <878v587kco.fsf@linaro.org> <515342D2.2080409@ti.com>
 <87txnw62la.fsf@linaro.org>
Message-ID: <51535B93.2040505@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 March 2013 01:24 AM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> On Thursday 28 March 2013 12:15 AM, Kevin Hilman wrote:
>>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>>>
>>>> Move the secondary CPU wakeup prepare code under smp_prepare_cpus(). 
>>>
>>> Why?
>>>
>> Because that code belongs to smp_prepare_cpus(). As I said
>> in earlier patches, it was remainder of the pen release code
>> which was borrowed from ARM code initially.
> 
> Sure, but that should be in the changelog.
> 
Yep. Will add above info in changelog.

Regards,
Santosh
