From: lznuaa@gmail.com (Frank Li)
Date: Mon, 4 Feb 2013 14:31:52 +0800
Subject: [PATCH 1/1] net: fec: fix miss init spinlock
In-Reply-To: <20130204.002410.508273179967651174.davem@davemloft.net>
References: <1359708986-23634-1-git-send-email-Frank.Li@freescale.com>
 <20130202.230851.809969826800130930.davem@davemloft.net>
 <CAHrpEqSLx-J-1SYC6OapqidY+U3acnTmNyOj8UrNRZwYZRXCoQ@mail.gmail.com>
 <20130204.002410.508273179967651174.davem@davemloft.net>
Message-ID: <CAHrpEqQwmAN8fBVQKOJzw5uD0WTfu9zR-gP1SPmq+JxocxjFSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> This breaks the build, tmreg_lock is only present in certain
>>> configurations.
>>
>> No, FEC have changed to check dramatically instead of static config.
>> You can look fec.h.  tmreg_lock is always defined.
>
> Not in the 'net' tree or you don't want this bug fixed there at all?

Sorry, I forget mask tree.
This patch is for net-next.

best regards
Frank Li
