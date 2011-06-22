From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 22 Jun 2011 20:51:14 +0200
Subject: [PATCH] ARM: remove legacy LEDS support from RealView and
	Versatile
In-Reply-To: <20100916090317.GB20197@n2100.arm.linux.org.uk>
References: <1284625415-8363-1-git-send-email-linus.walleij@stericsson.com>
	<20100916090317.GB20197@n2100.arm.linux.org.uk>
Message-ID: <BANLkTinXHbwM=M-AwvEZQUm-u9wX0OT-2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/9/16 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Thu, Sep 16, 2010 at 10:23:35AM +0200, Linus Walleij wrote:
>> We have merged proper support for the NEW_LEDS and LEDS_CLASS in
>> the RealView and Versatile family in plat-versatile, including the
>> heartbeat feature that was provided for these platforms so scrap
>> this old LEDS stuff from these platforms.
>
> Do we lose the display of activity across individual CPUs?

Yes it did. So I wrote a new patch set creating a new led trigger
to do it the (hopefully) right way instead.

And it only took me 10 months... :-/

Thanks,
Linus Walleij
