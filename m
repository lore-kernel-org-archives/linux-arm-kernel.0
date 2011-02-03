From: b-cousson@ti.com (Cousson, Benoit)
Date: Thu, 3 Feb 2011 13:51:26 +0100
Subject: [PATCH 2/6] omap4: prcm: Fix the CPUx clockdomain offsets
In-Reply-To: <4D4922B9.30501@ti.com>
References: <1296212688-21951-1-git-send-email-santosh.shilimkar@ti.com>	<1296212688-21951-3-git-send-email-santosh.shilimkar@ti.com>
	<87ipx3mduj.fsf@ti.com> <4D4922B9.30501@ti.com>
Message-ID: <4D4AA4CE.2020306@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On 2/2/2011 10:24 AM, Cousson, Benoit wrote:
> On 2/2/2011 2:20 AM, Hilman, Kevin wrote:
>> Santosh Shilimkar<santosh.shilimkar@ti.com>   writes:
>>
>>> CPU0 and CPU1 clockdomain is at the offset of 0x18 from the LPRM base.
>>> The header file has set it wrongly to 0x0. Offset 0x0 is for CPUx power
>>> domain control register
>>>
>>> Fix the same.
>>
>> Has this also been updated in the autogen scripts?
>>
>> Benoit?
> 
> No, I didn't see any patch to update that yet.
> 
> Santosh or Rajendra,
> Did you already fix it?

I updated the scripts with Santosh fixes and found a register name issue in this file.

The fix is inlined at the end. 
Santosh will include it in a new revision of the series.

Regards,
Benoit

---
