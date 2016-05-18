From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Wed, 18 May 2016 11:49:44 +0200
Subject: [RESEND PATCH v6 0/6] Add Ethernet support on STM32F429
In-Reply-To: <2535270.dCFPoM2olB@wuerfel>
References: <1462789899-13153-1-git-send-email-alexandre.torgue@gmail.com>
 <20160517.122527.1937360418899371800.davem@davemloft.net>
 <CALszF6AE7jkRX3sSNm=PCvEmkmZM-Sv5LxFSj7J3vMbvi8M5Cg@mail.gmail.com>
 <2535270.dCFPoM2olB@wuerfel>
Message-ID: <CALszF6AP52EAN68qH8Pup9uxqTnhoT8wigiKaZzgHns3m+NCgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-05-18 11:31 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
> On Wednesday 18 May 2016 09:48:53 Maxime Coquelin wrote:
>> 2016-05-17 18:25 GMT+02:00 David Miller <davem@davemloft.net>:
>> > From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> > Date: Tue, 17 May 2016 11:20:16 +0200
>> >
>> >> Hi David,
>> >>
>> >> 2016-05-09 21:06 GMT+02:00 David Miller <davem@davemloft.net>:
>> >>> From: Alexandre TORGUE <alexandre.torgue@gmail.com>
>> >>> Date: Mon,  9 May 2016 12:31:33 +0200
>> >>>
>> >>>> STM32F429 Chip embeds a Synopsys 3.50a MAC IP.
>> >>>> This series:
>> >>>>  -enhance current stmmac driver to control it (code already
>> >>>> available) and adds basic glue for STM32F429 chip.
>> >>>>  -Enable basic Net config in kernel.
>> >>>
>> >>> I assume this will go via the ARM tree, for the networking bits:
>> >> I would expect patches 1, 2 & 3 to got via your tree, to avoid conflicts.
>> >
>> > I don't think putting them all via the ARM tree is going to create much
>> > in the way of conflicts, and right now during the merge window offloading
>> > that work from me would really help my backlog a lot.
>>
>> Ok, I understand this is not the best time to pick it.
>>
>> Arnd, Olof & Kevin, would you accept to pick the series in your tree?
>>
>
> It's too late for v4.7 for us too, please pick up the arch/arm patches
> in your normal stm32 tree and send them to us along with any other changes
> you may have, and resend the driver by itself to netdev time after the
> merge window.
>
> The binding document can go either way, with the dts changes or with
> the driver. I see no dependencies between the patches, so we just need
> to land them all in v4.8.

Ok, this is good for me.
No problem to wait for v4.8.
I will take the arch/arm patches, and David the drivers/net/ ones once
v4.7-rc1 is out.

Thanks for your time,
Maxime
