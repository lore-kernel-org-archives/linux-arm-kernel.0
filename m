From: m-karicheri2@ti.com (Murali Karicheri)
Date: Thu, 15 Oct 2015 12:02:51 -0400
Subject: [PATCH v4 0/3]
In-Reply-To: <561E7792.409@oracle.com>
References: <1444832235-15263-1-git-send-email-m-karicheri2@ti.com>
 <561E7792.409@oracle.com>
Message-ID: <561FCE2B.8020802@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/2015 11:41 AM, santosh shilimkar wrote:
> 10/14/2015 7:17 AM, Murali Karicheri wrote:
>> This patch series enable accumulator queue support for K2 SoCs.
>> Accumulator
>> queues are a type of qmss queue that is monitored by the PDSP firmware
>> and
>> accumulated. Host is interrupted by PDSP firmware when packets become
>> available in a ring buffer shared between the host and PDSP.
>>
>> There was an issue raised when merging the original patch set at
>>   (1) https://lkml.org/lkml/2015/9/4/681
>>     [PATCH v1 1/2] soc: ti: display firmware file name as part of boot
>> log
>>   (2) https://lkml.org/lkml/2015/9/4/680
>>     [PATCH v1 2/2] ARM: dts: keystone: enable accumulator channels
>>
>> This series fixes the issues raised against v3. Maintainer, could you
>> please
>> apply this series to v4.4 next please at your earliest opportunity.
>>
> I have picked up the series. Thanks for quick turnaround.

Thanks Santosh. Could you send this pull request for v4.4 next. We want 
this merged to our internal release and if this is on next branch it 
will help.

Thanks

Murali
>
> Regards,
> Santosh
>
>


-- 
Murali Karicheri
Linux Kernel, Keystone
