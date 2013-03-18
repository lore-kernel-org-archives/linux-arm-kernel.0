From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Mar 2013 15:03:49 +0000
Subject: [PATCH] ARM: mach-moxart: platform port for MOXA ART SoC
In-Reply-To: <CACmBeS3aXs9vhc5ZYPbz5bjsYsSa6EzM12H4uPv706x0zU_5iw@mail.gmail.com>
References: <CACmBeS1NLFUYHBOVL28aCCzRrgXYGPZF9t3qj6AdcgaMkrPGoQ@mail.gmail.com>
 <201303151125.53999.arnd@arndb.de>
 <CACmBeS3aXs9vhc5ZYPbz5bjsYsSa6EzM12H4uPv706x0zU_5iw@mail.gmail.com>
Message-ID: <201303181503.49491.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 17 March 2013, Jonas Jensen wrote:
> Thank you for the feedback.
> 
> Some of the changes are sure to be a challenge for me, but I want to
> move this forward, and having a list helps.
> 
> 3.2.40 is as far as it'll go right now, nothing prints to UART
> starting with 3.3.8 (last tested, it's somewhere around there).
> 
> I have been advised to enable early_printk (by landley on freenode IRC #edev).

Yes, that is a good idea. I would also suggest that you don't try to port
all the code at once a few kernel versions at a time, but that you instead
move straight to the latest kernel, and basically start a new port one driver
at a time. Take one of the newer ports (highbank, virt, bcm, ...) as examples.

Since most of the code is now in drivers/ directories rather than arch/arm,
you can actually start getting stuff upstream before you have completed all
of it. If you have questions, I recommend asking on the #armlinux channel
on freenode, or here on the mailing list.

	Arnd
