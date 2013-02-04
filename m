From: davem@davemloft.net (David Miller)
Date: Mon, 04 Feb 2013 15:03:59 -0500 (EST)
Subject: [PATCH 1/1] net: fec: fix miss init spinlock
In-Reply-To: <CAHrpEqQwmAN8fBVQKOJzw5uD0WTfu9zR-gP1SPmq+JxocxjFSA@mail.gmail.com>
References: <CAHrpEqSLx-J-1SYC6OapqidY+U3acnTmNyOj8UrNRZwYZRXCoQ@mail.gmail.com>
 <20130204.002410.508273179967651174.davem@davemloft.net>
 <CAHrpEqQwmAN8fBVQKOJzw5uD0WTfu9zR-gP1SPmq+JxocxjFSA@mail.gmail.com>
Message-ID: <20130204.150359.599088894678143987.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <lznuaa@gmail.com>
Date: Mon, 4 Feb 2013 14:31:52 +0800

>>>> This breaks the build, tmreg_lock is only present in certain
>>>> configurations.
>>>
>>> No, FEC have changed to check dramatically instead of static config.
>>> You can look fec.h.  tmreg_lock is always defined.
>>
>> Not in the 'net' tree or you don't want this bug fixed there at all?
> 
> Sorry, I forget mask tree.
> This patch is for net-next.

Ok, applied to net-next.
