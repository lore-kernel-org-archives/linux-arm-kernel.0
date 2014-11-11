From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 11 Nov 2014 13:19:09 +0530
Subject: [PATCH v3 06/10] [media] platform: Make use of media_bus_format
 enum
In-Reply-To: <546193CF.8090107@ti.com>
References: <1415369269-5064-1-git-send-email-boris.brezillon@free-electrons.com>
 <1415369269-5064-7-git-send-email-boris.brezillon@free-electrons.com>
 <CA+V-a8t79gYYGcgg5wvM-eqW8H2D6WD7xM9t2Px=WHb2rf34ow@mail.gmail.com>
 <546193CF.8090107@ti.com>
Message-ID: <5461BF75.8000808@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 November 2014 10:12 AM, Sekhar Nori wrote:
> On Saturday 08 November 2014 02:48 PM, Prabhakar Lad wrote:
>> Hi,
>>
>> Thanks for the patch,
>>
>> On Fri, Nov 7, 2014 at 2:07 PM, Boris Brezillon
>> <boris.brezillon@free-electrons.com> wrote:
>>> In order to have subsytem agnostic media bus format definitions we've
>>> moved media bus definition to include/uapi/linux/media-bus-format.h and
>>> prefixed values with MEDIA_BUS_FMT instead of V4L2_MBUS_FMT.
>>>
>>> Reference new definitions in all platform drivers.
>>>
>>> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
>>> ---
>>>  arch/arm/mach-davinci/board-dm355-evm.c            |   2 +-
>>>  arch/arm/mach-davinci/board-dm365-evm.c            |   4 +-
>>>  arch/arm/mach-davinci/dm355.c                      |   7 +-
>>>  arch/arm/mach-davinci/dm365.c                      |   7 +-
>>
>> @Sekhar can you ack for the machine changes for davinci ?
> 
> Heh, I don't have 6/10 in my inbox but have rest of the series. Can you
> forward 6/10 to me?

Based on the patch Prabhakar forwarded, for the mach-davinci changes,
you can add:

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
