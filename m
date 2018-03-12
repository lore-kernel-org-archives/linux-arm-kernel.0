From: jeffy.chen@rock-chips.com (JeffyChen)
Date: Mon, 12 Mar 2018 17:47:14 +0800
Subject: [RESEND PATCH v4 1/4] mfd: syscon: Set name of regmap_config
In-Reply-To: <20180312091214.f6dwq6q3eqqblfnf@dell>
References: <20180309084351.32009-1-jeffy.chen@rock-chips.com>
 <20180309084351.32009-2-jeffy.chen@rock-chips.com>
 <20180312091214.f6dwq6q3eqqblfnf@dell>
Message-ID: <5AA64CA2.1080309@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On 03/12/2018 05:12 PM, Lee Jones wrote:
> On Fri, 09 Mar 2018, Jeffy Chen wrote:
>
>> >We are now allowing to register debugfs without a valid device, and not
>> >having a valid name will end up using "dummy*" to create debugfs dir.
>> >
>> >Signed-off-by: Jeffy Chen<jeffy.chen@rock-chips.com>
>> >---
>> >
>> >Changes in v4: None
>> >Changes in v3:
>> >Modify commit message.
>> >
>> >  drivers/mfd/syscon.c | 1 +
>> >  1 file changed, 1 insertion(+)
> Is this the RESEND I requested?  I can still only see this patch.
>
oops, sorry, i was using patman, and i force it to CC everyone in the 
cover letter's CC list, but that doesn't contain your mail address..i'll 
try another way :)
