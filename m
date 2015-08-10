From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 10 Aug 2015 12:05:31 -0500
Subject: [PATCH v3 15/31] arm64: SMP support
In-Reply-To: <55C8843D.8050600@linaro.org>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
 <1347035226-18649-16-git-send-email-catalin.marinas@arm.com>
 <CAOZdJXVoDJM3y2mnKO+91yf2EHogKfMjumjhhi85REAfhcJM=Q@mail.gmail.com>
 <20150806095621.GB17691@e104818-lin.cambridge.arm.com>
 <55C8843D.8050600@linaro.org>
Message-ID: <55C8D9DB.5080207@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hanjun Guo wrote:
>>
>> This code was inherited from arch/arm which initially was always dumping
>> the stack but it later gained the system_state check. Unless it's useful
>> to anyone for debugging purposes, I'm ok with removing it.
>
> Do you have patch for this one? My colleagues said that they met the
> same problem :)

Dropping the call to dump_stack() would probably be sufficient.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
