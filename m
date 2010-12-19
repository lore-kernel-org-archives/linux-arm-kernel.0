From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sun, 19 Dec 2010 21:48:46 +0100
Subject: [PATCH 01/20] mfd/ab8500: remove spi support
In-Reply-To: <20101209153634.GQ8884@sortiz-mobl>
References: <1291388753-14662-1-git-send-email-sundar.iyer@stericsson.com>
	<1291388753-14662-2-git-send-email-sundar.iyer@stericsson.com>
	<20101209142912.GM8884@sortiz-mobl>
	<33A307AF30D7BF4F811B1568FE7A9B18047C7D405F@EXDCVYMBSTM006.EQ1STM.local>
	<20101209153634.GQ8884@sortiz-mobl>
Message-ID: <AANLkTikG7CY9hcuSy6+na+xrjbJYdKE3tRysT0FKw5kD@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/12/9 Samuel Ortiz <sameo@linux.intel.com>:

>> [Sundar]
>> >> Since the Ab8500 v1.0, the SPI support is deprecated on the HW.
>> >I'm fine with that, but you really don't want to be able to support pre 1.0
>> >devices ?
>>
>> AFAIK, there aren't active pieces of those outside STE :)
> Ok, that's a good reason. Please add my:
> Acked-by: Samuel Ortiz <sameo@linux.intel.com>

This better be merged through the MFD tree. It touches a line in
the Makefile that has been changed since, the fixup is trivial but
it's orthogonal to the stuff I have in ux500-core anyway so Sam,
can you merge this into MFD?

(The other patch to remove the platform data for SPI mode
is in my ux500-core git already.)

Yours,
Linus Walleij
