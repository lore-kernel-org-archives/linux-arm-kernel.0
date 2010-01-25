From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 25 Jan 2010 10:28:50 +0100
Subject: [PATCH 1/2 RESEND#2] i2c/pxa: remove unused macro
In-Reply-To: <20100112105846.GA31145@pengutronix.de>
References: <1257754721-17325-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258658141-30340-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091208211810.GB13706@pengutronix.de>
	<20091208224456.0baf422b@hyperion.delvare>
	<20091208220724.GA14696@pengutronix.de>
	<20091209091146.78e8d7bb@hyperion.delvare>
	<20100112105846.GA31145@pengutronix.de>
Message-ID: <20100125092850.GA7378@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ben,

> > Ben, can you please add your tree to MAINTAINERS to make things clearer
> > for contributors?
I just sent out a patch for that to linux-i2c.

> In the meantime I have three i2c patches without any feedback by you.
> As Jean is convinced that you are responsible to take them can you
> please have a look and comment?
> 
> My patches are also available via git at
> 
> 	git://git.pengutronix.de/git/ukl/linux-2.6.git next/i2c
> 
> Shortlog and diffstat can be found below.
> 
> Best regards
> Uwe
> 
> Uwe Kleine-K?nig (2):
>       i2c/pxa: remove unused macro
>       i2c-imx: call ioremap only after request_mem_region
> 
> Wolfram Sang (1):
>       i2c/pxa: only define 'blue_murder'-function if DEBUG is #defined
hmm, you took one of those (the i2c-imx patch) but not the other two
with still no comment?!

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
