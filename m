From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 20 Jul 2010 23:10:02 +0200
Subject: [spi-devel-general] [PATCH 2/2] SPI: make the moved loopback test
	work
In-Reply-To: <812288.2599.qm@web180314.mail.gq1.yahoo.com>
References: <AANLkTinm_bvpcQogsTgVy5ZX1MFajVvDxBtVJ056sTyq@mail.gmail.com>
	<812288.2599.qm@web180314.mail.gq1.yahoo.com>
Message-ID: <AANLkTilqKs4WcSXxrZPUuaTudLD-P8ZeA6ShGyLmAIhi@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/20 David Brownell <david-b@pacbell.net>:

>> No matter how much I look at it, it seems like
>> all use of this require you to first register
>> *some* device,
>
> OBVIOUSLY. ?You can't use SPI without a device;
> it's like any other driver framework in Linux.
> What else should you expect???

I didn't expect anything else, it just makes it clear that
the part of my patch registering a dummy device is
not what is being disagreed upon, so this should be OK.

Yours,
Linus Walleij
