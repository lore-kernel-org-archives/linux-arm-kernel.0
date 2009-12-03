From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 3 Dec 2009 23:10:23 +0100
Subject: [PATCH 15/38] move s3c_adc_remove to .devexit.text
In-Reply-To: <20091203220718.GS4808@trinity.fluff.org>
References: <1259096853-18909-7-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-8-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-9-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-10-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-11-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-12-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-13-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-14-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-15-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091203220718.GS4808@trinity.fluff.org>
Message-ID: <20091203221023.GB13459@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

On Thu, Dec 03, 2009 at 10:07:18PM +0000, Ben Dooks wrote:
> On Tue, Nov 24, 2009 at 10:07:10PM +0100, Uwe Kleine-K?nig wrote:
> > The function s3c_adc_remove is used only wrapped by __devexit_p so define
> > it using __devexit.
> 
> Shall I put these into my tree?
Yes, I think your's is the right one. 

Thanks
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
