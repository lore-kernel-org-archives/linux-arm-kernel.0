From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 25 Jun 2010 07:10:16 +0200
Subject: 
In-Reply-To: <4C23B67C.7090207@eukrea.com>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<4C236EC2.8090506@eukrea.com>
	<20100624175528.GA14838@pengutronix.de>
	<4C23B67C.7090207@eukrea.com>
Message-ID: <20100625051016.GA31164@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 24, 2010 at 09:48:12PM +0200, Eric B?nard wrote:
> Hi Uwe,
>
> Le 24/06/2010 19:55, Uwe Kleine-K?nig a ?crit :
>> On Thu, Jun 24, 2010 at 04:42:10PM +0200, Eric B?nard wrote:
>>> Le 24/06/2010 15:48, Uwe Kleine-K?nig a ?crit :
>>>> this is the next step in the project "clean up the imx port" targeting
>>>> 2.6.36.  The highlights this time are:
>>>>
>>> maybe that would be interesting to rebase your patch serie against
>>> Sascha's imx-for-2.6.36 in order to include new boards (especially for
>>> the patches which change registering nand, i2c, spi and uart) ?
>> No, I don't want to rebase it.  I hope Sascha just merges my tree.  Do
>> you know of any problems, I havn't checked if Sascha's branch introduces
>> any new users of devices I removed.  I make a mental note to check thatOK
>> after Sascha merged.
>>
> There are at least my i.MX25 and i.MX35 machines that I would have  
> updated to you patch serie and tested but trying to merge your branch  
> over Sasha's imx-for-2.6.36 + kernel.org tree at 2.6.35-rc3 leads to at  
> least 9 conflitcs.
> How do you manage to merge this simply in order to test it ?
> I added your branch as a remote tree, then fetched it, then merged it :  
> is there any magic git sequence missing here that would help to reduce  
> the number of conflicts ?
No, but these conflicts aren't that hard to resolve.  Check out my
imx/for-2.6.36-merged branch.

BTW there are two warnings about 'otg_pdata' and 'usbh2_pdata' defined
but not used with the config I tested.  And it would have been more
consistent to name your machine source file mach-eukrea_cpuimx25.c.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
