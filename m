From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Fri, 25 Jun 2010 08:54:48 +0200
Subject: [PATCH 1/2] net/fec: clean suspend/resume
In-Reply-To: <20100624.220548.02285361.davem@davemloft.net>
References: <1276853351-20790-1-git-send-email-eric@eukrea.com>
	<20100624.220548.02285361.davem@davemloft.net>
Message-ID: <4C2452B8.4030002@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 25/06/2010 07:05, David Miller a ?crit :
> From: Eric B?nard<eric@eukrea.com>
> Date: Fri, 18 Jun 2010 11:29:10 +0200
>
>> Commit 59d4289b83b11379d867e2f7146904b19cc96404 converted fec to dev_pm_ops but
>> didn't update the suspend/resume functions thus leading to the following warning :
>> "initialization from incompatible pointer type" when CONFIG_PM is set.
>>
>> This patch also fixe a few indentation and style around CONFIG_PM area.
>>
>> Signed-off-by: Eric B?nard<eric@eukrea.com>
>
> So, where's patch 2/2?
>
Sorry, there is no patch 2/2 for netdev, the 2/2 was only for 
linux-arm-kernel : 
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-June/018387.html

Eric
