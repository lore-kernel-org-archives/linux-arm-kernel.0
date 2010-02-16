From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 16 Feb 2010 17:19:02 +0100
Subject: [PATCH] imx-serial-excessive-status-clearing-on-break.patch
In-Reply-To: <4B7928CA.8050408@warmcat.com>
References: <20100201122853.21848.90945.stgit@otae.warmcat.com>
	<4B7928CA.8050408@warmcat.com>
Message-ID: <20100216161902.GV17643@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On Mon, Feb 15, 2010 at 11:58:18AM +0100, Andy Green wrote:
> On 02/01/10 13:28, Somebody in the thread at some point said:
>
>> -			writel(temp | USR2_BRCD, sport->port.membase + USR2);
>> +			writel(USR2_BRCD, sport->port.membase + USR2);
>
> Hi Sascha -
>
> What is the disposition of this patch?  It solves a real problem in the  
> imx serial but it is just sitting there for two weeks.

Sorry, I missed it. Applied now.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
