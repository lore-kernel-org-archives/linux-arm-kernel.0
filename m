From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 17 Jun 2010 11:49:31 +0200
Subject: [PATCH 05/10] arm/zImage: annotate debug functions about
	corrupted registers
In-Reply-To: <AANLkTingMRjp-7IUddg7gV9eXVBLRmd598MqH7ykbeCk@mail.gmail.com>
References: <20100610102427.GC31057@pengutronix.de>
	<1276165636-20150-5-git-send-email-u.kleine-koenig@pengutronix.de>
	<AANLkTingMRjp-7IUddg7gV9eXVBLRmd598MqH7ykbeCk@mail.gmail.com>
Message-ID: <20100617094931.GA27312@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 17, 2010 at 05:37:52PM +0800, Eric Miao wrote:
> 2010/6/10 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
> Not sure if this is absolutely necessary, though.
I had to analyze which registers are corrupted to create the last patch
in the series.  I don't have strong feelings but thought to document my
findings.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
