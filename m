From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 5 Feb 2018 11:31:22 +0530
Subject: [PATCH v6 24/41] ARM: dm644x: add new clock init using common
 clock framework
In-Reply-To: <d8325090-e369-5a1a-b34a-8174123b01ff@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-25-git-send-email-david@lechnology.com>
 <28508a72-2fc7-1dc2-8a2c-997139d70831@ti.com>
 <d8325090-e369-5a1a-b34a-8174123b01ff@lechnology.com>
Message-ID: <bc304a78-662a-d57a-cda4-fe7507e7a6cf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 February 2018 11:36 PM, David Lechner wrote:
> On 02/02/2018 08:39 AM, Sekhar Nori wrote:
>> On Saturday 20 January 2018 10:44 PM, David Lechner wrote:
>>> This adds the new board-specific clock init in mach-davinci/dm644x.c
>>> using the new common clock framework drivers.
>>>
>>> The #ifdefs are needed to prevent compile errors until the entire
>>> ARCH_DAVINCI is converted.
>>>
>>> Also clean up the #includes since we are adding some here.
>>>
>>> Signed-off-by: David Lechner <david@lechnology.com>
>>
>> I did not notice this before, but the subject line for this and other
>> patches needs to be "ARM: davinci: "
> 
> so "davinci" == "dm644x" and not any other SoC?

No, I meant "ARM: davinci: dm644x: " instead of just "ARM: dm644x".

Thanks,
Sekhar
