From: shijie8@gmail.com (Huang Shijie)
Date: Thu, 18 Oct 2012 11:11:15 -0400
Subject: [PATCH] dma: add new DMA control commands
In-Reply-To: <201210181251.15116.marex@denx.de>
References: <1350538335-29026-1-git-send-email-b32955@freescale.com>
 <201210181049.21556.marex@denx.de> <507FC827.40601@freescale.com>
 <201210181251.15116.marex@denx.de>
Message-ID: <CAMiH66HCDLZaxXckQz1bfqscNm2X2480HTr4bFHdJNteDLb=ig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2012 at 6:51 AM, Marek Vasut <marex@denx.de> wrote:
> Dear Huang Shijie,
>
>> ? 2012?10?18? 16:49, Marek Vasut ??:
>> > Dear Huang Shijie,
>> >
>> >> ? 2012?10?18? 16:16, Marek Vasut ??:
>> >>> So we can't stream data from the chip? About time to adjust the MTD
>> >>> framework to allow that. Maybe implement a command queue?
>> >>
>> >> IMHO, it's not possible. Because the READ-PAGE(00h-30h) command needs to
>> >> check the busy status
>> >> which means we have to stop in the middle, so we can not chain the all
>> >> the read-pages DMA commands.
>> >
>> > Can the DMA not branch?
>>
>> it's too complicated to the MTD layer, as well as the gpmi driver.
>
> Can you please elaborate ?
could you read the nand spec about how to read a page out with the
READ-PAGE(00-30) command,
and tell me how to make the DMA branch?
I really have no idea about how to make the DMA branch.

thanks
Huang Shijie
.


> Best regards,
> Marek Vasut
