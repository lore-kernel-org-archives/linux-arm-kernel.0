From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 26 Apr 2011 17:37:37 +0200
Subject: [PM8921 MFD V5 0/6] pm8921 core and subdevices
In-Reply-To: <20110426150746.GF3175@sortiz-mobl>
References: <1302039657-19395-1-git-send-email-adharmap@codeaurora.org>
	<20110426150746.GF3175@sortiz-mobl>
Message-ID: <20110426153737.GZ31131@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Samuel,

On Tue, Apr 26, 2011 at 05:07:47PM +0200, Samuel Ortiz wrote:
> > - mfd_cell does not have platfrom_data anymore - use mfd data instead.
> I'm currently moving that away from the mfd_cell structure, in my for-next
> branch. mfd_cell now has a platform_data pointer back, and you should use
> mfd_get_cell() if you really need to reach the mfd_cell pointer (which you
> apparently don't). 
> Could you please generate patchs 3 and 4 against this branch ?
I just saw commit

	5828fdb (mfd: Use mfd cell platform_data for mc13xxx cells platform bits)

in next. It has a Cc: for me, but I didn't got it by mail.

Did you send a mail and it didn't reach me? Or maybe you just forgot to
send the mail out?

Anyhow, Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> for
5828fdb, but I wonder if it's worth to add a new member to struct
platform_device for that to work.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
