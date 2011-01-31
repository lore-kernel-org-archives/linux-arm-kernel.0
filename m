From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 31 Jan 2011 11:26:20 +0100
Subject: [PATCH] ARM: print FPGA info on plat-versatile variants
In-Reply-To: <20110130195934.GC27436@n2100.arm.linux.org.uk>
References: <1296128890-18765-1-git-send-email-linus.walleij@stericsson.com>
	<20110130195934.GC27436@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinNhc6yxmQpWTT97fjg6u_gT_rx1Rqcjk9kZPG2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/30 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> On Thu, Jan 27, 2011 at 12:48:10PM +0100, Linus Walleij wrote:
>> This adds a small piece of code that displays some basic FPGA
>> characteristics for the Integrator, Versatile, RealView and
>> Versatile Express reference platforms. Tested on RealView
>> variants.
>
> I think it needs a few tweaks for Versatile Express:

I have a problem to do regression compilation on vexpress
since it lacks a defconfig, does anyone one at hand?

Or is there some other preferred way of testing vexpress?

Yours,
Linus Walleij
