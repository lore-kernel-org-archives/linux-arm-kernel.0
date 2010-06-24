From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 24 Jun 2010 19:55:28 +0200
Subject: 
In-Reply-To: <4C236EC2.8090506@eukrea.com>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<4C236EC2.8090506@eukrea.com>
Message-ID: <20100624175528.GA14838@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Eric,

On Thu, Jun 24, 2010 at 04:42:10PM +0200, Eric B?nard wrote:
> Hi Uwe,
>
> Le 24/06/2010 15:48, Uwe Kleine-K?nig a ?crit :
>> this is the next step in the project "clean up the imx port" targeting
>> 2.6.36.  The highlights this time are:
>>
> maybe that would be interesting to rebase your patch serie against
> Sascha's imx-for-2.6.36 in order to include new boards (especially for  
> the patches which change registering nand, i2c, spi and uart) ?
No, I don't want to rebase it.  I hope Sascha just merges my tree.  Do
you know of any problems, I havn't checked if Sascha's branch introduces
any new users of devices I removed.  I make a mental note to check that
after Sascha merged.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
