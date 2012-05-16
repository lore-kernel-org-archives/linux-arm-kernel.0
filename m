From: stigge@antcom.de (Roland Stigge)
Date: Wed, 16 May 2012 15:36:50 +0200
Subject: [RFC] pl08x: don't use dma_slave_config direction argument
In-Reply-To: <20120516131720.GE9571@n2100.arm.linux.org.uk>
References: <20120516110451.GA9571@n2100.arm.linux.org.uk>
 <4FB39C62.3030305@antcom.de> <20120516125253.GD9571@n2100.arm.linux.org.uk>
 <4FB3A5E7.7060505@antcom.de> <20120516131720.GE9571@n2100.arm.linux.org.uk>
Message-ID: <4FB3AD72.2010501@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2012 03:17 PM, Russell King - ARM Linux wrote:
>>>> * SLC driver says:
>>>>
>>>> lpc32xx-nand 20020000.flash: FIFO not empty!
>>>> lpc32xx-nand 20020000.flash: FIFO held data too long
>>>> lpc32xx-nand 20020000.flash: DMA FIFO failure
>>>>
>>>> Any hints, before I find the time to sort out all the details with
>>>> amba-pl08x?
>>>
>>> Nothing jumps out; it would be useful if you could bisect the small
>>> series - I did the conversion in small steps so it should be easy to
>>> track down.  And it shouldn't take too long to rebuild between each
>>> iteration.  Whatever it is, it's probably going to be a stupid mistake
>>> somewhere.
>>
>> The problem first appears with patch #4.
> 
> I said it would be something silly...

Works fine now, including series 1-7.

Thanks,

Roland
