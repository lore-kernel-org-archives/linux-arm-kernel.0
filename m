From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Fri, 25 Jun 2010 09:23:49 +0200
Subject: 
In-Reply-To: <20100625071751.GB31164@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<4C236EC2.8090506@eukrea.com>
	<20100624175528.GA14838@pengutronix.de>
	<4C23B67C.7090207@eukrea.com>
	<20100625051016.GA31164@pengutronix.de>
	<4C245238.7010501@eukrea.com>
	<20100625071751.GB31164@pengutronix.de>
Message-ID: <4C245985.6040703@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 25/06/2010 09:17, Uwe Kleine-K?nig a ?crit :
>>> but not used with the config I tested.  And it would have been more
>>> consistent to name your machine source file mach-eukrea_cpuimx25.c.
>>>
>> OK so this would require the same renaming for cpuimx27&  35 as actually
>> its consitent between the 3 boards. Should I send a patch to rename them
>> ?
> If you don't, then I will do :-)  I would recommend to wait until Sascha
> merged though.
>
OK will do.

> While testing I found another problem.  There are two definitions of
> MACH_EUKREA_MBIMXSD_BASEBOARD that conflict.  For me
> MACH_EUKREA_MBIMXSD_BASEBOARD doesn't appear in .config if I select
> MACH_EUKREA_CPUIMX25.
>
Yes I saw this after tewting Sascha's tree as I was initialy working on 
different branches. I would have expected Kconfig to not care about the 
one of the unselected architecture but that not the case.
Please see the patch I just sent to merge the baseboard support in one file.

Eric
