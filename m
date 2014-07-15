From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 15 Jul 2014 19:22:27 +0200
Subject: [PATCH 1/3 v6] spi: s3c64xx: fix broken "cs_gpios" usage in the
 driver
In-Reply-To: <CAHfPSqA5MMtaY5kb85xmZXkN62a+otgDAM93Gxn9d9fHv39k=g@mail.gmail.com>
References: <1405316506-27855-1-git-send-email-ch.naveen@samsung.com>
 <1405316506-27855-2-git-send-email-ch.naveen@samsung.com>
 <53C55D17.90109@samsung.com>
 <CAHfPSqA5MMtaY5kb85xmZXkN62a+otgDAM93Gxn9d9fHv39k=g@mail.gmail.com>
Message-ID: <53C56353.2040902@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.07.2014 19:21, Naveen Krishna Ch wrote:
> Hello Tomasz,
> 
> On 15 July 2014 22:25, Tomasz Figa <t.figa@samsung.com> wrote:
>> Hi Naveen,
>>
>> On 14.07.2014 07:41, Naveen Krishna Chatradhi wrote:
>>> Since, (3146bee spi: s3c64xx: Added provision for dedicated cs pin)
>>>
>>> spi-s3c64xx.c driver expects
>>> 1. chip select gpios from "cs-gpio"(singular) under the
>>>    "controller-data" node of the client/slave device of the SPI.
>>
>> Please work a bit more on readability of your commit messages,
>> especially in terms of using correct terminology to avoid unnecessary
>> confusion.
>>
>> s/'chip select gpios'/'chip select GPIO pins'/
>> s/'"cs-gpio"(singular)'/'"cs-gpio" property'/
>> s/'client/slave device of the SPI'/'SPI device'/
> 
> Sure, I'm working on that.
> 
>>
>> More things like this follow in rest of the text below.
>>
>> Otherwise I believe the code after this patch does the right thing, so:
>>
>> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> 
> I've submitted another patch set which does the same functionality
> as this patch set. I believe the new series is more cleaner in terms of
> patch separation and documentation.
> 
> Kindly, let me know your comments on that series.
> http://www.spinics.net/lists/arm-kernel/msg347634.html

Right. I noticed it just now and am looking at it.

Best regards,
Tomasz
