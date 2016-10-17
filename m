From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 17 Oct 2016 14:51:03 +0200
Subject: [GIT PULL] ARM: mvebu: fixes for v4.8 (#3)
In-Reply-To: <4853532.G9HOlQ47QA@wuerfel> (Arnd Bergmann's message of "Wed, 21
 Sep 2016 22:33:01 +0200")
References: <87intq5z0o.fsf@free-electrons.com> <4853532.G9HOlQ47QA@wuerfel>
Message-ID: <87insrf8aw.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
 
 On mer., sept. 21 2016, Arnd Bergmann <arnd@arndb.de> wrote:

> On Tuesday, September 20, 2016 6:14:47 PM CEST Gregory CLEMENT wrote:
>> mvebu fixes for 4.8 (part 3)
>> 
>> - Select corediv clk for all mvebu v7 SoC
>> - Fix clocksource for CP110 master SPI0 for Armada 7K/8K
>> 
>
> Pulled into fixes, thanks!

I don't see this patch in the v4.8 or the v4.9-rc1.

I think it slipped through the cracks as there were the only one in the
fixes branches.

Do you think you could make them part of your next pull request for
fixes for 4.9-rc2?

Thanks,

Gregory

>
> 	Arnd
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
