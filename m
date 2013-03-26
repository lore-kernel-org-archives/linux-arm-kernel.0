From: lznuaa@gmail.com (Frank Li)
Date: Wed, 27 Mar 2013 07:17:09 +0800
Subject: [PATCH 1/1] enet: fec: fix fail resume from suspend state
In-Reply-To: <20130326.121940.937673963522554506.davem@davemloft.net>
References: <1364264097-26157-1-git-send-email-Frank.Li@freescale.com>
 <20130326.121940.937673963522554506.davem@davemloft.net>
Message-ID: <CAHrpEqQ2oThx1mTmyD=pBXJofsOx2wWdAA_DfygZu+FKT+ibSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/27 David Miller <davem@davemloft.net>:
> From: Frank Li <Frank.Li@freescale.com>
> Date: Tue, 26 Mar 2013 10:14:57 +0800
>
>> Without this patch
>> 1. boot with nfs (no_console_suspend)
>> 2. echo mem >/sys/power/state
>> 3. wakeup by wakesource
>> 4. print "eth0: tx queue full"
>>
>> This fix above problem by reinit bd queue at restart function
>>
>> Signed-off-by: Frank Li <Frank.Li@freescale.com>
>
> Patch applies neither to 'net' nor 'net-next'.

I base on 3.9 -rc3, I will rebase it to net.

>
> Please respin this cleanly against current sources.
