From: lznuaa@gmail.com (Frank Li)
Date: Thu, 7 Feb 2013 09:37:43 +0800
Subject: [PATCH v2 1/2 net-next] net: fec: fix miss init spinlock
In-Reply-To: <20130206.150431.408313770070806281.davem@davemloft.net>
References: <1360045577-6266-1-git-send-email-Frank.Li@freescale.com>
 <20130206.150431.408313770070806281.davem@davemloft.net>
Message-ID: <CAHrpEqTOsan3EyK-YZXiZ76HtpT9MVWm=QQk5V+mT0reNU9twQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/2/7 David Miller <davem@davemloft.net>:
> From: Frank Li <Frank.Li@freescale.com>
> Date: Tue, 5 Feb 2013 14:26:16 +0800
>
>> Change from v1 to v2
>>  - avoid reinit hwreg_lock twice
>
> I already applied your v1 patch, so you have to revert that spin_lock_init()
> call in this change.
>
> Please do that and respin this patch series.

Okay
