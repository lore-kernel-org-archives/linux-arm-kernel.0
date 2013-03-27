From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 28 Mar 2013 02:17:48 +0530
Subject: [PATCH 4/9] ARM: OMAP4+: Remove the un-necessary cache flush
 from hotplug code
In-Reply-To: <87ehf07kfn.fsf@linaro.org>
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
 <1361373527-21695-5-git-send-email-santosh.shilimkar@ti.com>
 <87ehf07kfn.fsf@linaro.org>
Message-ID: <51535AF4.3090607@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 March 2013 12:13 AM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> This was added with intial port where OMAP PM support wasn't existing
>> and only simple WFI based hooks were used.
>>
>> This should have been cleaned up while adding the PM support but some
>> how fall through cracks.
> 
> Changelog describes a bit of history, but does not it's no longer
> needed.
> 
I thought "This should have been cleaned up while adding PM support"
means its no longer needed. At least I meant that way.

Anyway I will just make it explicit.

Regards,
Santosh
