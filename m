From: b.brezillon@overkiz.com (boris brezillon)
Date: Fri, 07 Jun 2013 17:36:01 +0200
Subject: [RFC PATCH 02/50] ARM: at91: add PMC main clock
In-Reply-To: <20130607173014.7186ddc0@skate>
References: <1370615115-16979-1-git-send-email-b.brezillon@overkiz.com>
 <1370615115-16979-3-git-send-email-b.brezillon@overkiz.com>
 <20130607173014.7186ddc0@skate>
Message-ID: <51B1FDE1.8090109@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/2013 17:30, Thomas Petazzoni wrote:
> Dear Boris BREZILLON,
>
> On Fri,  7 Jun 2013 16:24:10 +0200, Boris BREZILLON wrote:
>
>> + * This mainram is free software; you can redistribute it and/or modify
> Looks like you did some funky 'sed' over your source files. In every
> clk driver, instead of "program" you have "<name of clock>ram" :-)
Oups.

I based all my implementations on programmable clocks and replaced every 
instance
of the "prog" pattern by the clock name.
That's why "program" is replaced by "<name of clock>ram".

I'll fix it.

Thanks
>
> Thomas
