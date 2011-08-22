From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 22 Aug 2011 14:29:48 +0200
Subject: [PATCH 1/4 v4] drivers: create a pin control subsystem
In-Reply-To: <20110819165252.GC4016@kroah.com>
References: <1313747630-32258-1-git-send-email-linus.walleij@stericsson.com>
	<20110819104816.GA5030@pulham.picochip.com>
	<CACRpkdZhg_1WM37uqT1PNmpUjWS_groWJmNnR4SBjqJ6LFQQWQ@mail.gmail.com>
	<201108191636.29161.arnd@arndb.de>
	<20110819165252.GC4016@kroah.com>
Message-ID: <CACRpkdaS6KiZGxSOE=T4ErXAPoWoYWYWFNVancWjQV1L4SCAew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2011 at 6:52 PM, Greg KH <greg@kroah.com> wrote:

>> IIRC Greg would prefer now to never have had the distinction
>> and wants to make all future uses use a bus_type.
>
> Yes, that is totally correct. ?Kay has also written much more about this
> and why this is the way forward many times in the past, see lkml
> archives for the details if anyone is interested.

Nah I trust you, I will switch it to use bus_type instead no problem.

Thanks!
Linus Walleij
