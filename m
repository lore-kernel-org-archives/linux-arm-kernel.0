From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 25 May 2017 13:04:00 +0100
Subject: [RFC PATCH v2 5/7] ARM: Kconfig: Kill CONFIG_VECTORS_BASE
In-Reply-To: <20170525112725.GA6309@afzalpc>
References: <1495187206-14303-1-git-send-email-vladimir.murzin@arm.com>
 <1495187206-14303-6-git-send-email-vladimir.murzin@arm.com>
 <20170525112725.GA6309@afzalpc>
Message-ID: <1125c9e3-a5d1-f3df-e1aa-d8dcebf38dfc@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 25/05/17 12:27, afzal mohammed wrote:
> Hi,
> 
> On Fri, May 19, 2017 at 10:46:44AM +0100, Vladimir Murzin wrote:
>> The last user of CONFIG_VECTORS_BASE has gone, so kill it.
>>
>> Reported-by: Afzal Mohammed <afzal.mohd.ma@gmail.com>
> 
> Ending up in this tag has left me scratching my head & amused :),
> whether you keep any tag or not for me, i do not have any issues.

According to [1]:

"This series also does the preparation for CONFIG_VECTORS_BASE removal."

IIRC, that time only thing which stopped you from complete CONFIG_VECTORS_BASE
removal was MPU code, so I don't see a reason not to give you a credit ;)

[1] https://lkml.org/lkml/2017/1/21/251

Cheers
Vladimir

> 
> Regards
> afzal
> 
