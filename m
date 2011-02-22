From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 22 Feb 2011 21:19:01 +0800
Subject: [PATCH] ARM: pxa: support 806MHz operating points for PXA31x
	processors A2 stepping
In-Reply-To: <AANLkTikTHnz+7C-QmXaHwFE0a+pw7U-t2JP11a0qdoyU@mail.gmail.com>
References: <1297786849.2596.13.camel@phoenix>
	<4D5AB09C.9000106@compulab.co.il>
	<AANLkTino2vLisNgKeyXppuHwDyhLMMAcOOZjA0hgmkj6@mail.gmail.com>
	<4D637557.2070707@compulab.co.il>
	<AANLkTikTHnz+7C-QmXaHwFE0a+pw7U-t2JP11a0qdoyU@mail.gmail.com>
Message-ID: <AANLkTin7E9j6Q32JR-t13ekpdveiSrPCqAorT08DdM=6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Another thing (which could be related to the patch) is the package marking.
>> We have PXA3xx SoCs marked A2 stepping, but C624, which means that the
>> highest running frequency should not exceed 624MHz.
>
> This means not all PXA310 A2 stepping supports 806Mhz.
> Can we differentiate the Cxxx option in software?
>
>> What is your PXA3xx A2 marking in respect to Cxxx option?
>
> Mine is 88AP310-A2-BGK2C806.
>

Haojian,

Can you help check on the stepping/markings on these processors
to see which of them supports 806MHz, reliably?

- eric
