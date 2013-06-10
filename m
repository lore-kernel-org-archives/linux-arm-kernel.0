From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 10 Jun 2013 10:03:52 -0700
Subject: [PATCH 13/14] ARM: AM33XX: hwmod data: irq,
 dma and addr info clean up
In-Reply-To: <51B58FE9.5040309@ti.com> (Lokesh Vutla's message of "Mon, 10 Jun
 2013 14:05:53 +0530")
References: <1369845494-30231-1-git-send-email-santosh.shilimkar@ti.com>
 <1369845494-30231-14-git-send-email-santosh.shilimkar@ti.com>
 <alpine.DEB.2.02.1306060355320.15042@utopia.booyaka.com>
 <87zjv2ooxi.fsf@linaro.org> <51B58FE9.5040309@ti.com>
Message-ID: <877gi1ew3r.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lokesh,

Lokesh Vutla <lokeshvutla@ti.com> writes:

> Hi Kevin,
>
> On Friday 07 June 2013 03:57 AM, Kevin Hilman wrote:
>> Paul Walmsley <paul@pwsan.com> writes:
>>
>>> On Wed, 29 May 2013, Santosh Shilimkar wrote:
>>>
>>>> From: Vaibhav Hiremath <hvaibhav@ti.com>
>>>>
>>>> AM33XX only supports DT boot mode and with addition of
>>>> extracting module resources like, irq, dma and address space
>>>> from DT block, so now we can remove duplicate information from
>>>> hwmod data file.
>>>
>>> OK, guess I'll take your word for it that it all works.  The
>>> BeagleBone-white with appended DTB hasn't booted here since v3.7.
>>> And the BeagleBone-black with discrete DTB doesn't boot at all with
>>> current mainline, only with the TI vendor kernel & DTB...
>>
>> Anyone care to shed light on what's missing for BeagleBone boot with
>> mainline currently?
> I have tested BeagleBone boot with today's mainline bootloader and
> kernel. It boots perfectly fine.

Can you post git trees + branch names (and/or commit IDs) and also
kernel config please?

Thanks,

Kevin
