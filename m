From: davem@davemloft.net (David Miller)
Date: Tue, 17 May 2016 12:25:27 -0400 (EDT)
Subject: [RESEND PATCH v6 0/6] Add Ethernet support on STM32F429
In-Reply-To: <CALszF6Cfs02-tGvFqpyJpUy7jSfjGTY8fVaaLQ8iQaGfCxvDtQ@mail.gmail.com>
References: <1462789899-13153-1-git-send-email-alexandre.torgue@gmail.com>
 <20160509.150634.213732321950308841.davem@davemloft.net>
 <CALszF6Cfs02-tGvFqpyJpUy7jSfjGTY8fVaaLQ8iQaGfCxvDtQ@mail.gmail.com>
Message-ID: <20160517.122527.1937360418899371800.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Date: Tue, 17 May 2016 11:20:16 +0200

> Hi David,
> 
> 2016-05-09 21:06 GMT+02:00 David Miller <davem@davemloft.net>:
>> From: Alexandre TORGUE <alexandre.torgue@gmail.com>
>> Date: Mon,  9 May 2016 12:31:33 +0200
>>
>>> STM32F429 Chip embeds a Synopsys 3.50a MAC IP.
>>> This series:
>>>  -enhance current stmmac driver to control it (code already
>>> available) and adds basic glue for STM32F429 chip.
>>>  -Enable basic Net config in kernel.
>>
>> I assume this will go via the ARM tree, for the networking bits:
> I would expect patches 1, 2 & 3 to got via your tree, to avoid conflicts.

I don't think putting them all via the ARM tree is going to create much
in the way of conflicts, and right now during the merge window offloading
that work from me would really help my backlog a lot.

Thanks.
