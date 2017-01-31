From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 31 Jan 2017 19:13:14 +0100
Subject: [PATCH 6/7] arm64: arch_timer: document Hisilicon erratum
 161010101
In-Reply-To: <20170131142906.GB22283@arm.com>
References: <1485865196-12742-1-git-send-email-mark.rutland@arm.com>
 <1485865196-12742-7-git-send-email-mark.rutland@arm.com>
 <20170131142906.GB22283@arm.com>
Message-ID: <b30b48cb-d079-7c69-7fb1-470ad9dace7b@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/01/2017 15:29, Will Deacon wrote:
> On Tue, Jan 31, 2017 at 12:19:55PM +0000, Mark Rutland wrote:
>> From: Ding Tianhong <dingtianhong@huawei.com>
>>
>> Now that we have a workaround for Hisilicon erratum 161010101, notes
>> this in the arm64 silicon-errata document.
>>
>> The new config option is too long to fit in the existing kconfig column,
>> so this is widened to accomodate it.
>>
>> Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
>> [Mark: split patch, reword commit message]
>> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>> ---
>>  Documentation/arm64/silicon-errata.txt | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
>> index 4a5e6cc..e12c926 100644
>> --- a/Documentation/arm64/silicon-errata.txt
>> +++ b/Documentation/arm64/silicon-errata.txt
>> @@ -63,3 +63,5 @@ stable kernels.
>>  | Cavium         | ThunderX SMMUv2 | #27704          | N/A                              |
>>  |                |                 |                 |                                  |
>>  | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585              |
>> +|                |                 |                 |                                  |
>> +| Hisilicon      | Hip0{5,6,7}     | #161010101      | HISILICON_ERRATUM_161010101      |
>> -- 
>> 1.9.1
> 
> I'd like to take this one via arm64, then you can drop it along with the
> first patch in the series and I can deal with the conflicts in the text
> file.
> 
> Daniel, are you ok with that? This file isn't part of the clocksource
> code and is purely an informative document that we maintain to help ARM
> vendors know which errata we're working around.

Yes, no problem.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
