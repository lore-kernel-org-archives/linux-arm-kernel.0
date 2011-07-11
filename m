From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 11 Jul 2011 11:47:06 +0200
Subject: [PATCH V3] MMC: PM: add suspend/resume in atmel-mci
In-Reply-To: <m2iprbkw6v.fsf@bob.laptop.org>
References: <1309530754.4373.3.camel@hcegtvedt.norway.atmel.com>	<1309779505-25509-1-git-send-email-nicolas.ferre@atmel.com>
	<m2iprbkw6v.fsf@bob.laptop.org>
Message-ID: <4E1AC69A.6060307@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 09/07/2011 22:58, Chris Ball :
> Hi,
> 
> On Mon, Jul 04 2011, Nicolas Ferre wrote:
>> Take care of slots while going to suspend state.
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> ---
>> V3: take care of each slot SUSPENDED state
>>     (adding a status bit in the slot "flags")
>> V2: move to pm_ops
> 
> Thanks, I've merged v3 of this patch for mmc-next/3.1 with Felipe's

You mean v4, I have checked: everything is ok.

> Reviewed-by, and your [2/2] kconfig change.

Perfect, thanks a lot Chris!
-- 
Nicolas Ferre
