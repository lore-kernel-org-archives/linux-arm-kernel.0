From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 28 Mar 2013 02:22:51 +0530
Subject: [PATCH 1/9] ARM: OMAP4+: Use common scratchpad SAR RAM offsets
 for all architectures
In-Reply-To: <20130327204930.GM10155@atomide.com>
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
 <1361373527-21695-2-git-send-email-santosh.shilimkar@ti.com>
 <87mwto7ki5.fsf@linaro.org> <51535B66.60307@ti.com>
 <20130327204930.GM10155@atomide.com>
Message-ID: <51535C23.5000405@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 March 2013 02:19 AM, Tony Lindgren wrote:
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [130327 13:52]:
>> On Thursday 28 March 2013 12:11 AM, Kevin Hilman wrote:
>>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>>>
>>>> From: Tero Kristo <t-kristo@ti.com>
>>>>
>>>> Simplifies code and also allows the re-use as is on OMAP5 devices.
>>>
>>> nit: changelog here is rather weak.  It claims "simplifies code" but
>>> it's not obvious from the patch how changing a few #defines does that.
>>>
>> I agree. Basically the offset are chosen such a way that they can
>> work on OMAP4 and OMAP5 instead of having two separate sets.
>> Will expand the changelog to make it clear.
> 
> You might want to mention also that the offsets are only used by
> the kernel to save and restore registers from so people don't
> think those are hardare registers and that the patch might break
> some things.
> 
Yeah. Will mention that.

Regards,
Santosh
