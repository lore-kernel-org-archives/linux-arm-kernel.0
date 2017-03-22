From: tbaicar@codeaurora.org (Baicar, Tyler)
Date: Tue, 21 Mar 2017 21:05:24 -0600
Subject: [PATCH V13 09/10] trace, ras: add ARM processor error trace event
In-Reply-To: <e1e63cbb-a75e-af11-4fa0-446b40999ee8@huawei.com>
References: <1490136425-4324-1-git-send-email-tbaicar@codeaurora.org>
 <1490136425-4324-10-git-send-email-tbaicar@codeaurora.org>
 <e1e63cbb-a75e-af11-4fa0-446b40999ee8@huawei.com>
Message-ID: <060cefca-0020-411a-a27d-ede7102cac09@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Xie XiuQi,

On 3/21/2017 8:48 PM, Xie XiuQi wrote:
> Reviewed-by: Xie XiuQi <xiexiuqi@huawei.com>
Thank you!
Tyler
>
> On 2017/3/22 6:47, Tyler Baicar wrote:
>> Currently there are trace events for the various RAS
>> errors with the exception of ARM processor type errors.
>> Add a new trace event for such errors so that the user
>> will know when they occur. These trace events are
>> consistent with the ARM processor error section type
>> defined in UEFI 2.6 spec section N.2.4.4.
>>
>> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
>> Acked-by: Steven Rostedt <rostedt@goodmis.org>
>> ---
>>   drivers/acpi/apei/ghes.c    |  8 +++++++-
>>   drivers/firmware/efi/cper.c |  1 +
>>   drivers/ras/ras.c           |  1 +
>>   include/ras/ras_event.h     | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 54 insertions(+), 1 deletion(-)
>>
>>

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
