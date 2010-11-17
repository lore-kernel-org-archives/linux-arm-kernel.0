From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 17 Nov 2010 07:06:14 +0100
Subject: [RFC][PATCH 00/11] ARM: imx: Add initial i.MX28 support
In-Reply-To: <AANLkTi=Hws0q8tWi+tkZss2gfYh9om5PZ+TB809_CcjX@mail.gmail.com>
References: <1289831795-4373-1-git-send-email-shawn.guo@freescale.com>
	<20101116101508.GK6017@pengutronix.de>
	<AANLkTim=ACL-PW-n0MWu_+KD8n19ttq_NfEnRzsMp6SU@mail.gmail.com>
	<20101116172444.GS8942@pengutronix.de>
	<AANLkTi=Hws0q8tWi+tkZss2gfYh9om5PZ+TB809_CcjX@mail.gmail.com>
Message-ID: <20101117060614.GY8942@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

> plat-stmp3xxx is not an option for me.  Another reason is it has the
> support for mach-stmp37xx.  If I change anything in plat-stmp3xxx, I
> can not even find a board to test mach-stmp37xx.  For me
> plat-stmp3xxx, mach-stmp37xx and mach-stmp378x seem out of
> maintaining.  I do not see they are moving.
> 
> So at the end of the day, mach-mxs + plat-mxs becomes the option that
> could work for both of us, right?  Correct me I misunderstood your
> comments.
As long as you don't use more than mach directory there is no need to
populate plat-mxs.  Everything can go into mach-mxs.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
