From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Fri, 25 Jun 2010 08:52:40 +0200
Subject: 
In-Reply-To: <20100625051016.GA31164@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<4C236EC2.8090506@eukrea.com>
	<20100624175528.GA14838@pengutronix.de>
	<4C23B67C.7090207@eukrea.com>
	<20100625051016.GA31164@pengutronix.de>
Message-ID: <4C245238.7010501@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 25/06/2010 07:10, Uwe Kleine-K?nig a ?crit :
> On Thu, Jun 24, 2010 at 09:48:12PM +0200, Eric B?nard wrote:
>> How do you manage to merge this simply in order to test it ?
>> I added your branch as a remote tree, then fetched it, then merged it :
>> is there any magic git sequence missing here that would help to reduce
>> the number of conflicts ?
> No, but these conflicts aren't that hard to resolve.  Check out my
> imx/for-2.6.36-merged branch.

most of them may not be hard to resolve but that creates more work to 
test the patches (and that create more work for Sascha to integrate the 
patches in its tree). Thanks for your merged branch, I'll test asap.

> BTW there are two warnings about 'otg_pdata' and 'usbh2_pdata' defined

should already be fixed in :
http://git.pengutronix.de/?p=imx/linux-2.6.git;a=commit;h=4ecca63bf70aec86745c4bb631ada8b15e02e855

> but not used with the config I tested.  And it would have been more
> consistent to name your machine source file mach-eukrea_cpuimx25.c.
>
OK so this would require the same renaming for cpuimx27 & 35 as actually 
its consitent between the 3 boards. Should I send a patch to rename them ?

Thanks,
Eric
