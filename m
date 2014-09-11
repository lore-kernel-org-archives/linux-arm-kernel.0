From: yangyingliang@huawei.com (Yang Yingliang)
Date: Thu, 11 Sep 2014 15:55:47 +0800
Subject: [PATCH] arm64: add guard macro of unistd.h to prevent double
 inclusion
In-Reply-To: <20140909123938.GL1754@arm.com>
References: <1410235185-16652-1-git-send-email-yangyingliang@huawei.com>
 <20140909123938.GL1754@arm.com>
Message-ID: <54115583.8080306@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/9/9 20:39, Will Deacon wrote:
> On Tue, Sep 09, 2014 at 04:59:45AM +0100, Yang Yingliang wrote:
>> Add guard macros in both uapi/asm/unistd.h and asm/unistd.h.
>>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>  arch/arm64/include/asm/unistd.h      | 5 +++++
>>  arch/arm64/include/uapi/asm/unistd.h | 5 +++++
>>  2 files changed, 10 insertions(+)
> 
> We probably need something similar for unistd32.h too, as lib/compat_audit.c
> now includes that.
> 
> Can you post a v2 please?
> 
> Will
> 
> 
OK, I'll send a v2.

Regards,
Yang
