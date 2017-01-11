From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 11 Jan 2017 18:50:14 +0000
Subject: [PATCH v3 2/5] arm64: Work around Falkor erratum 1003
In-Reply-To: <2069d58c-0b81-dad4-511f-05e7d002eb34@codeaurora.org>
References: <20170111144118.17062-1-cov@codeaurora.org>
 <20170111144118.17062-2-cov@codeaurora.org>
 <20170111180627.GG20288@e104818-lin.cambridge.arm.com>
 <20170111183339.GC29247@leverpostej>
 <5da456f8-fcc5-b6e2-d58b-01a671da595b@codeaurora.org>
 <20170111183738.GD29247@leverpostej>
 <2069d58c-0b81-dad4-511f-05e7d002eb34@codeaurora.org>
Message-ID: <1e9509cf-315d-f7cb-3ff5-cfa835b3720c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[finally, some proper bikeshedding]

On 11/01/17 18:40, Timur Tabi wrote:
> On 01/11/2017 12:37 PM, Mark Rutland wrote:
>> The name, as it is, is perfectly descriptive.
>>
>> Let's not sacrifice legibility over a non-issue.
> 
> I don't want to kick a dead horse or anything, but changing it to 
> QCOM_FLKR_ERRATUM_1003 would eliminate all the spacing problems without 
> sacrificing anything.

Other than not being able to grep for the core name in the source tree,
how do you suggest we pronounce FLKR? Because so far, it rolls off the
tongue in an interesting way...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
