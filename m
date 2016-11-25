From: slash.tmp@free.fr (Mason)
Date: Fri, 25 Nov 2016 16:21:49 +0100
Subject: Tearing down DMA transfer setup after DMA client has finished
In-Reply-To: <yw1xoa137fvr.fsf@unicorn.mansr.com>
References: <58356EA8.2010806@free.fr> <20161125045549.GC2698@localhost>
 <20161125124528.GJ14217@n2100.armlinux.org.uk>
 <yw1xtwav9092.fsf@unicorn.mansr.com>
 <20161125133436.GK14217@n2100.armlinux.org.uk>
 <yw1xlgw78y8k.fsf@unicorn.mansr.com>
 <20161125135830.GL14217@n2100.armlinux.org.uk>
 <yw1xh96v8xnb.fsf@unicorn.mansr.com>
 <20161125141708.GM14217@n2100.armlinux.org.uk>
 <d996bcdb-2413-770c-84d1-1b12ccd74477@free.fr>
 <yw1xoa137fvr.fsf@unicorn.mansr.com>
Message-ID: <cba10848-57b1-c28c-2a60-83eb9da4cc63@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/11/2016 16:12, M?ns Rullg?rd wrote:

> Mason writes:
> 
>> I've had several talks with the HW dev, and I don't think they
>> anticipated the need to mux the 3 channels. In their minds,
>> customers would choose at most 3 devices to support, and
>> assign one channel to each device statically.
>>
>> In fact, in tango4, supported devices are:
>> A) NAND Flash controllers 0 and 1
>> NB: the upstream driver only uses controller 0
>> B) IDE or SATA controllers 0 and 1
>> C) a few crypto HW blocks which do not work as expected (unused)
>>
>> Customers typically use 1 channel for NAND, maybe 1 for SATA,
>> and 1 channel remains unused.
> 
> The hardware has two sata controllers, and I have a board that uses both.

I don't have the tango3 client devices in mind, but
1 NAND + 2 SATA works out alright for 3 channels, right?

Regards.
