From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 05 Mar 2014 22:03:05 +0300
Subject: [PATCH] irq-gic: remove file name from heading comment
In-Reply-To: <alpine.DEB.2.02.1403050112180.18573@ionos.tec.linutronix.de>
References: <201312140224.53928.sergei.shtylyov@cogentembedded.com>
 <52D5CCFB.1090205@cogentembedded.com> <53166B67.2060804@cogentembedded.com>
 <alpine.DEB.2.02.1403050112180.18573@ionos.tec.linutronix.de>
Message-ID: <531774E9.2000501@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 03/05/2014 03:27 AM, Thomas Gleixner wrote:

>>>> File names in the heading comments  fell out of favor long ago, and this
>>>> one
>>>> weren't even changed when the driver was moved from arch/arm/common/, so
>>>> remove
>>>> it at last...

>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>>>> ---
>>>> The patch is against the 'irq/core' branch of the 'tip.git' repo.

>>>      Thomas, is there a chance that you merge this patch for 3.14? Is it even
>>> the right branch for cleanups (I'm seeing fixes there)?

>>     Thomas, will you ever reply to me? Who's maintaining the GIC driver, you?
>> Or the patches shoud just go in via arm-soc.git?

> That patch is so important^Wtrivial that it really can go via the
> obvious trivial at kernel.org

    I've never been redirected to trivial. I thought only typo fixes and such 
go there. The question is why it did take so long to tell me to do this...

> Sigh....

    Yes... thanks anyway, I'll try sending to trivial.

WBR, Sergei
