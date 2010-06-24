From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Thu, 24 Jun 2010 21:48:12 +0200
Subject: 
In-Reply-To: <20100624175528.GA14838@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>	<4C236EC2.8090506@eukrea.com>
	<20100624175528.GA14838@pengutronix.de>
Message-ID: <4C23B67C.7090207@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Le 24/06/2010 19:55, Uwe Kleine-K?nig a ?crit :
> On Thu, Jun 24, 2010 at 04:42:10PM +0200, Eric B?nard wrote:
>> Le 24/06/2010 15:48, Uwe Kleine-K?nig a ?crit :
>>> this is the next step in the project "clean up the imx port" targeting
>>> 2.6.36.  The highlights this time are:
>>>
>> maybe that would be interesting to rebase your patch serie against
>> Sascha's imx-for-2.6.36 in order to include new boards (especially for
>> the patches which change registering nand, i2c, spi and uart) ?
> No, I don't want to rebase it.  I hope Sascha just merges my tree.  Do
> you know of any problems, I havn't checked if Sascha's branch introduces
> any new users of devices I removed.  I make a mental note to check thatOK
> after Sascha merged.
>
There are at least my i.MX25 and i.MX35 machines that I would have 
updated to you patch serie and tested but trying to merge your branch 
over Sasha's imx-for-2.6.36 + kernel.org tree at 2.6.35-rc3 leads to at 
least 9 conflitcs.
How do you manage to merge this simply in order to test it ?
I added your branch as a remote tree, then fetched it, then merged it : 
is there any magic git sequence missing here that would help to reduce 
the number of conflicts ?

Thanks,
Eric
