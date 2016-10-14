From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 14 Oct 2016 17:28:58 +0100
Subject: [PATCH V3 02/10] ras: acpi/apei: cper: generic error data entry
 v3 per ACPI 6.1
In-Reply-To: <912acc88-fbaf-2576-8048-1fcc67439600@codeaurora.org>
References: <1475875882-2604-1-git-send-email-tbaicar@codeaurora.org>
 <1475875882-2604-3-git-send-email-tbaicar@codeaurora.org>
 <3f17d0a8-6b63-5792-903a-341effaae432@arm.com>
 <c17a0c03-5037-d88d-f096-4cc72dbfcb99@codeaurora.org>
 <064dca7d-0625-c0d0-09ae-72ef7abdc63f@arm.com>
 <912acc88-fbaf-2576-8048-1fcc67439600@codeaurora.org>
Message-ID: <38c7c9ac-e8ad-6fb5-3ee9-3ba85e4b8299@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/10/16 20:37, Baicar, Tyler wrote:
> Hello Suzuki,
>
> On 10/13/2016 2:50 AM, Suzuki K Poulose wrote:
>> On 12/10/16 23:10, Baicar, Tyler wrote:

>>>> Please could you keep the people who reviewed/commented on your series in the past,
>>>> whenever you post a new version ?
>>> Do you mean to just send the new version to their e-mail directly in addition to the lists? If so, I will do that next time.
>>
>> If you send a new version of a series to the list, it is a good idea to keep
>> the people who commented (significantly) on your previous version in Cc, especially
>> when you have addressed their feedback. That will help them to keep track of the
>> series. People can always see the new version in the list, but then it is so easy
>> to miss something in the 100s of emails you get each day. I am sure people have
>> special filters for the emails based on if they are in Cc/To etc.
>>
> Okay, understood. I'll make sure to add those who have commented in the cc/to list to avoid the e-mail filters.

Thanks !

>> Is it always the same endianness as that of the CPU ?
> It is a fair assumption that the firmware populating this record will use a CPU of the same endianness. There is no mechanism in the spec to indicate otherwise.

Yep, you are right. The EFI expects the EL2/EL1 to be of the same endianness

Cheers
Suzuki
