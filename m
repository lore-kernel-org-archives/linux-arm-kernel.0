From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 3 Oct 2017 11:16:00 +0100
Subject: [PATCH 0/5] firmware: arm_scpi: series with smaller improvements
In-Reply-To: <de10ab6e-2a47-2baa-fefa-20fdfcacc9e8@gmail.com>
References: <c245d2fa-2aa0-fa40-21a7-318e8db3b763@gmail.com>
 <18e22585-801a-18e7-a42b-8e10035abc37@arm.com>
 <de10ab6e-2a47-2baa-fefa-20fdfcacc9e8@gmail.com>
Message-ID: <02d02d87-afdd-1bb9-4d22-39ff566e4e31@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/10/17 23:10, Heiner Kallweit wrote:
> Am 02.10.2017 um 13:25 schrieb Sudeep Holla:
>>
>>
>> On 29/09/17 22:25, Heiner Kallweit wrote:
>>> This series includes smaller improvements to make all memory allocations
>>> device-managed and eventually get rid of scpi_remove. This also improves
>>> the cleanup path in scpi_probe.
>>>
>> Overall looks good, just one question on DVFS in patch 3. I vaguely
>> remember the need to support that in past.
>>
> I will remove the prepopulating in patch 3 and just submit the fix
> described in my reply to your review comment.
> Do you want me to re-submit the full patch series or just patches 3-5?
> 

It's up to you, am fine either way.

-- 
Regards,
Sudeep
