From: cov@codeaurora.org (Christopher Covington)
Date: Mon, 16 Jan 2017 09:26:36 -0500
Subject: [PATCH v3 2/5] arm64: Work around Falkor erratum 1003
In-Reply-To: <20170111184555.GF29247@leverpostej>
References: <20170111144118.17062-1-cov@codeaurora.org>
 <20170111144118.17062-2-cov@codeaurora.org>
 <20170111180627.GG20288@e104818-lin.cambridge.arm.com>
 <20170111183339.GC29247@leverpostej>
 <5da456f8-fcc5-b6e2-d58b-01a671da595b@codeaurora.org>
 <20170111183738.GD29247@leverpostej>
 <2069d58c-0b81-dad4-511f-05e7d002eb34@codeaurora.org>
 <20170111184555.GF29247@leverpostej>
Message-ID: <44a23442-7d9a-3493-c56f-3bab7c4be30d@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 01/11/2017 01:45 PM, Mark Rutland wrote:
> On Wed, Jan 11, 2017 at 12:40:42PM -0600, Timur Tabi wrote:
>> On 01/11/2017 12:37 PM, Mark Rutland wrote:
>>> The name, as it is, is perfectly descriptive.
>>>
>>> Let's not sacrifice legibility over a non-issue.
>>
>> I don't want to kick a dead horse or anything, but changing it to
>> QCOM_FLKR_ERRATUM_1003 would eliminate all the spacing problems
>> without sacrificing anything.
> 
> The CPU is called "Falkor", not "FLKR", and we're not coming up with an
> ACPI table name...
> 
> The ARM Ltd. erratum numbers are global to all parts, so we don't
> include the part name. Is the 1003 erratum number specific to Falkor?
>
> If it's global, you could use QCOM_ERRATUM_1003 instead.

E1003 is specific to Falkor, and hopefully just its first major revision.
Qualcomm Technology's first/previous generation ARMv8 custom
microarchitecture used errata numbers below 1000. I am not aware of
global coordination in the numbering, unfortunately.

> Otherwise, QCOM_FALKOR_ERRATUM_1003 is preferable.

Thanks,
Cov

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code
Aurora Forum, a Linux Foundation Collaborative Project.
