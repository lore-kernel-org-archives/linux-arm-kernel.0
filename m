From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 30 Jun 2010 21:16:37 +0200
Subject: [PATCH] Add support for Vista Silicon i.MX27 Visstrim_M10 board.
In-Reply-To: <4C2B80B1.1090308@eukrea.com>
References: <1277912661-24065-1-git-send-email-javier.martin@vista-silicon.com>
	<20100630170025.GD23534@tarshish> <4C2B80B1.1090308@eukrea.com>
Message-ID: <20100630191637.GA11643@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 30, 2010 at 07:36:49PM +0200, Eric B?nard wrote:
> Hi Baruch,
>
> Le 30/06/2010 19:00, Baruch Siach a ?crit :
>> On Wed, Jun 30, 2010 at 05:44:21PM +0200, Javier Martin wrote:
>>>
>>> Signed-off-by: Javier Martin<javier.martin@vista-silicon.com>
>>> ---
>>>   arch/arm/mach-mx2/Kconfig                          |    8 +
>>>   arch/arm/mach-mx2/Makefile                         |    1 +
>>>   arch/arm/mach-mx2/mach-imx27_visstrim_m10.c        |  279 ++++++++++++++++++++
>>
>> This directory are no more. You should rebase your work on the imx-for-2.6.36
>> branch of the imx tree at git://git.pengutronix.de/git/imx/linux-2.6.git
>>
> unless I made a mistake with git, Uwe's patch serie seems to have been  
> removed from this branch (I think it was merged this morning but I don't  
> find it anymore now).
>
> It is still available here :  
> git://git.pengutronix.de/git/ukl/linux-2.6.git in branch  
> imx/for-2.6.36-merged
Note that this changed earlier today, too.  Sascha rebased his branch
and I merged his new tree after doing some cosmetics to mine, too.  I
expect Sascha to pull my -merged branch soon.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
