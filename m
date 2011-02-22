From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue, 22 Feb 2011 15:22:05 +0200
Subject: [PATCH] ARM: pxa: support 806MHz operating points for PXA31x
	processors A2 stepping
In-Reply-To: <AANLkTikTHnz+7C-QmXaHwFE0a+pw7U-t2JP11a0qdoyU@mail.gmail.com>
References: <1297786849.2596.13.camel@phoenix>
	<4D5AB09C.9000106@compulab.co.il>
	<AANLkTino2vLisNgKeyXppuHwDyhLMMAcOOZjA0hgmkj6@mail.gmail.com>
	<4D637557.2070707@compulab.co.il>
	<AANLkTikTHnz+7C-QmXaHwFE0a+pw7U-t2JP11a0qdoyU@mail.gmail.com>
Message-ID: <4D63B87D.8040107@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/22/11 12:38, Axel Lin wrote:

> 2011/2/22 Igor Grinberg <grinberg@compulab.co.il>:
>> Another thing (which could be related to the patch) is the package marking.
>> We have PXA3xx SoCs marked A2 stepping, but C624, which means that the
>> highest running frequency should not exceed 624MHz.
> This means not all PXA310 A2 stepping supports 806Mhz.
> Can we differentiate the Cxxx option in software?

Some time ago I spoke with our local Marvell representative... and he said that this
information cannot be retrieved by software.

So this makes me think, that we may be need an option for the platform data
passed from the board (assuming that board should know what SoC is installed).

Or a kernel command line parameter... something much like Eric proposed:
http://www.spinics.net/lists/arm-kernel/msg92900.html

>> What is your PXA3xx A2 marking in respect to Cxxx option?
> Mine is 88AP310-A2-BGK2C806.

nice! :)

-- 
Regards,
Igor.
