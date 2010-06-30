From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Wed, 30 Jun 2010 19:36:49 +0200
Subject: [PATCH] Add support for Vista Silicon i.MX27 Visstrim_M10 board.
In-Reply-To: <20100630170025.GD23534@tarshish>
References: <1277912661-24065-1-git-send-email-javier.martin@vista-silicon.com>
	<20100630170025.GD23534@tarshish>
Message-ID: <4C2B80B1.1090308@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

Le 30/06/2010 19:00, Baruch Siach a ?crit :
> On Wed, Jun 30, 2010 at 05:44:21PM +0200, Javier Martin wrote:
>>
>> Signed-off-by: Javier Martin<javier.martin@vista-silicon.com>
>> ---
>>   arch/arm/mach-mx2/Kconfig                          |    8 +
>>   arch/arm/mach-mx2/Makefile                         |    1 +
>>   arch/arm/mach-mx2/mach-imx27_visstrim_m10.c        |  279 ++++++++++++++++++++
>
> This directory are no more. You should rebase your work on the imx-for-2.6.36
> branch of the imx tree at git://git.pengutronix.de/git/imx/linux-2.6.git
>
unless I made a mistake with git, Uwe's patch serie seems to have been 
removed from this branch (I think it was merged this morning but I don't 
find it anymore now).

It is still available here : 
git://git.pengutronix.de/git/ukl/linux-2.6.git in branch 
imx/for-2.6.36-merged

Eric
