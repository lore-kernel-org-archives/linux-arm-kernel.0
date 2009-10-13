From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 13 Oct 2009 10:24:47 +0200
Subject: [PATCH] serial/atmel_serial: Fix another fallout of the change
	to BUILD_BUG_ON
In-Reply-To: <20091013092644.72c78334@hskinnemoen-d830>
References: <1255417680-25609-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091013092644.72c78334@hskinnemoen-d830>
Message-ID: <20091013082447.GA3194@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andrew,

On Tue, Oct 13, 2009 at 09:26:44AM +0200, Haavard Skinnemoen wrote:
> Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:
> > Commit 8c87df457cb5 fixed BUILD_BUG_ON with the result that some
> > expressions (e.g. "not really constant" ones) result in a build failure.
> > 
> > Some of these were fixed in 8c87df457cb5, but not serial/atmel_serial.
> 
> This patch fixes the same issue:
> 
> http://lkml.org/lkml/2009/10/6/305
Can you please take this and add my Ack?

If you cannot find it anymore in your inbox, you can get it from
http://article.gmane.org/gmane.linux.kernel/898575/raw

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
