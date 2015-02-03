From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 03 Feb 2015 21:28:11 +0800
Subject: [PATCH v8 17/21] clocksource / arch_timer: Parse GTDT to
 initialize arch timer
In-Reply-To: <3447958.XfVzbZ6OCs@vostro.rjw.lan>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <1422881149-8177-18-git-send-email-hanjun.guo@linaro.org>
 <3447958.XfVzbZ6OCs@vostro.rjw.lan>
Message-ID: <54D0CCEB.2020200@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?02?03? 06:23, Rafael J. Wysocki wrote:
> On Monday, February 02, 2015 08:45:45 PM Hanjun Guo wrote:
>> Using the information presented by GTDT (Generic Timer Description Table)
>> to initialize the arch timer (not memory-mapped).
>>
>> CC: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Originally-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> Tested-by: Yijing Wang <wangyijing@huawei.com>
>> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
>> Tested-by: Jon Masters <jcm@redhat.com>
>> Tested-by: Timur Tabi <timur@codeaurora.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   arch/arm64/kernel/time.c             |   7 ++
>>   drivers/clocksource/arm_arch_timer.c | 132 ++++++++++++++++++++++++++++-------
>
> An ACK from Thomas Gleixner is necessary for that.

I will CC Thomas in the change log in next version
with both patch 16/17.

Thanks
Hanjun
