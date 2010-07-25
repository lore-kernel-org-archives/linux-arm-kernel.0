From: grant.likely@secretlab.ca (Grant Likely)
Date: Sun, 25 Jul 2010 01:48:37 -0600
Subject: [spi-devel-general] [PATCH 2/2] SPI: make the moved loopback test
	work
In-Reply-To: <AANLkTilqKs4WcSXxrZPUuaTudLD-P8ZeA6ShGyLmAIhi@mail.gmail.com>
References: <AANLkTinm_bvpcQogsTgVy5ZX1MFajVvDxBtVJ056sTyq@mail.gmail.com>
	<812288.2599.qm@web180314.mail.gq1.yahoo.com>
	<AANLkTilqKs4WcSXxrZPUuaTudLD-P8ZeA6ShGyLmAIhi@mail.gmail.com>
Message-ID: <AANLkTinFqwexhf5g3JMeN2eedRHbo8eTgaD-eqfWkU=B@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 20, 2010 at 3:10 PM, Linus Walleij
<linus.ml.walleij@gmail.com> wrote:
> 2010/7/20 David Brownell <david-b@pacbell.net>:
>
>>> No matter how much I look at it, it seems like
>>> all use of this require you to first register
>>> *some* device,
>>
>> OBVIOUSLY. ?You can't use SPI without a device;
>> it's like any other driver framework in Linux.
>> What else should you expect???
>
> I didn't expect anything else, it just makes it clear that
> the part of my patch registering a dummy device is
> not what is being disagreed upon, so this should be OK.

What's disagreed with is the dummy device knowing the intimate working
details of the SPI bus driver.

g.
