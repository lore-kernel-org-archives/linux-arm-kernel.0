From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 19 Jan 2015 23:58:14 +0100
Subject: [PATCH 1/2] clk: pxa: add pxa3xx clock driver
In-Reply-To: <54BC3EB8.9020304@zonque.org> (Daniel Mack's message of "Mon, 19
 Jan 2015 00:16:08 +0100")
References: <1420577139-30556-1-git-send-email-robert.jarzmik@free.fr>
 <87ppar4onn.fsf@free.fr> <54BC3EB8.9020304@zonque.org>
Message-ID: <87h9vmgyyh.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Mack <daniel@zonque.org> writes:

> Hi Robert,
>
> On 01/06/2015 09:53 PM, Robert Jarzmik wrote:
>> I'd need a test to see if the pxa3xx clocks are actually working.
>> I prepared a tree in here :
>>   git fetch https://github.com/rjarzmik/linux work/clocks-pxa
>
> Very sorry for the long delay on this. I finally got around to give this
> a try, and at a glance, things look fine.
Good.

> However, I noticed a number of regressions in the PXA3xx area which I
> will investigate on later this week, one of which causing the system to
> crash on suspend. But that seems unrelated to the clocking patches, so
> I'd say they're good to go in the next merge window.
>
> Will get back once I figured out the other issues that I'm seeing.
Very well. Good hunt.

Cheers.

-- 
Robert
