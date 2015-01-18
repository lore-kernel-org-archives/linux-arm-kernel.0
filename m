From: daniel@zonque.org (Daniel Mack)
Date: Mon, 19 Jan 2015 00:16:08 +0100
Subject: [PATCH 1/2] clk: pxa: add pxa3xx clock driver
In-Reply-To: <87ppar4onn.fsf@free.fr>
References: <1420577139-30556-1-git-send-email-robert.jarzmik@free.fr>
 <87ppar4onn.fsf@free.fr>
Message-ID: <54BC3EB8.9020304@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

On 01/06/2015 09:53 PM, Robert Jarzmik wrote:
> I'd need a test to see if the pxa3xx clocks are actually working.
> I prepared a tree in here :
>   git fetch https://github.com/rjarzmik/linux work/clocks-pxa

Very sorry for the long delay on this. I finally got around to give this
a try, and at a glance, things look fine.

However, I noticed a number of regressions in the PXA3xx area which I
will investigate on later this week, one of which causing the system to
crash on suspend. But that seems unrelated to the clocking patches, so
I'd say they're good to go in the next merge window.

Will get back once I figured out the other issues that I'm seeing.


Thanks for working on this,
Daniel
