From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 2 Nov 2017 12:47:05 +0100
Subject: [GIT PULL] Mediatek: 32-bit DT update for v4.15
In-Reply-To: <1509423579.10793.10.camel@mtkswgap22>
References: <c7145c00-b2b9-780c-0bfd-15f7d8a08dd6@gmail.com>
 <CAK8P3a3NWwoe0mX45WrFONyiHt9eWTTMziEc+rjqSfr5QZv8xQ@mail.gmail.com>
 <1509423579.10793.10.camel@mtkswgap22>
Message-ID: <e8fdd9a9-ce13-8804-aea0-46becc6f9730@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 10/31/2017 05:19 AM, Ryder Lee wrote:
> Hi Arnd,
> 
> We have 3 root ports in MT7623, but this is a bug in this chip where the
> HW designers wired the IRQs in a nonstandard way. We've tried to
> statically assign the bus portion of the address part in the parent
> interrupt-map before, but this approach cannot handle the case - if we
> attach the device in random order.
> 

Ryder, please don't top post :)

> Thanks.
> 
> On Mon, 2017-10-30 at 13:42 +0100, Arnd Bergmann wrote:
>> On Mon, Oct 23, 2017 at 12:06 AM, Matthias Brugger
>> <matthias.bgg@gmail.com> wrote:
>>>
>>> ----------------------------------------------------------------
>>> - mt76233 add PCIe node
>>
>> Could you clarify what the subnodes in the PCI node are for? It seems odd
>> to have "interrupt-map" properties in both the pcie controller and its child
>> nodes, and I want to ensure this is following the standard PCIe binding before
>> I pull it.
>>

Arnd, I didn't found the pull request in your next/dt branch.
Is there more clarification needed from our side?

Regards,
Matthias
