From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 4 Dec 2013 16:59:25 +0100
Subject: [PATCH 3/3] usb: ohci-at91: use device managed clk retrieval
In-Reply-To: <529F4F73.7060706@interlog.com>
References: <Pine.LNX.4.44L0.1312041021120.1329-100000@iolanthe.rowland.org>
 <529F4F73.7060706@interlog.com>
Message-ID: <CA+Ln22Ffhr9VXofUDjV3U0p+Lcg65QPdtAqhZWyboDk6ZQU2rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/12/4 Douglas Gilbert <dgilbert@interlog.com>:
> On 13-12-04 04:21 PM, Alan Stern wrote:
>>
>> On Wed, 4 Dec 2013, boris brezillon wrote:
>>
>>>> The patches look fine to me.  But only the 1/3 patch fixes a bug; the
>>>> others merely change the resource management.
>>>
>>>
>>> Do you want me to split this series ?
>>>    1) the 1st patch that should be merged in 3.13
>>>    2) patches 2 to 4 that might be applied later
>>
>>
>> That probably would make Greg happier.
>
>
> Putting my initial reporter hat on, USB OHCI is
> completely broken in lk 3.13.0 rc1 and rc2 for AT91
> family members. So it is difficult to make the
> situation worse. IMO the whole 4 patches should go
> in, since it only impacts that family. Also the kernel
> is more than a month away from release. Perhaps the
> naysayers should be looking around for whatever else
> the "of/irq: Pass trigger type in IRQ resource flags"
> patch has broken.

...or rather whatever brokenness it has uncovered.

Best regards,
Tomasz
