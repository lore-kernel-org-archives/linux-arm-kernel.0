From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 4 Dec 2014 17:33:05 +0100
Subject: [GIT PULL] at91: defconfig for 3.19 #1
In-Reply-To: <3905790.gg6cCb9BU6@wuerfel>
References: <1417537711-15608-1-git-send-email-nicolas.ferre@atmel.com>
 <3905790.gg6cCb9BU6@wuerfel>
Message-ID: <54808CC1.2010502@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 04/12/2014 17:28, Arnd Bergmann a ?crit :
> On Tuesday 02 December 2014 17:28:31 Nicolas Ferre wrote:
>>
>> The following changes since commit 0df1f2487d2f0d04703f142813d53615d62a1da4:
>>
>>   Linux 3.18-rc3 (2014-11-02 15:01:51 -0800)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-defconfig
>>
>> for you to fetch changes up to 4cd275f762a21cf21768e327873ba2883c839281:
>>
>>   ARM: at91/defconfig: add DM9000 to at91_dt (2014-12-01 16:30:00 +0100)
>>
>> ----------------------------------------------------------------
>> First batch of defconfigs for AT91 / 3.19:
>> - use NEON for all C-A5, neon code handles the !NEON case
>> - add new XDMA driver
>> - add some useful drivers as we only have a single defconfig for all
>>   AT91SAM9/RM9200
> 
> I just noticed that this is based on -rc3, while the next/defconfig branch
> so far is based on -rc1. If you don't mind, could you rebase your
> branch on -rc1 as well and send it again so I can avoid the backmerge?

Sure, I do it right now.

Stay tuned ;-)

Bye,
-- 
Nicolas Ferre
