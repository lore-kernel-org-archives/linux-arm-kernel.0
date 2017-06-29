From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 29 Jun 2017 20:47:02 +0200
Subject: [PATCH v3 0/9] Add and make use of a common rs485 device tree
 parsing function
In-Reply-To: <20170629151200.GA16362@kroah.com>
References: <20170626090803.10981-1-u.kleine-koenig@pengutronix.de>
 <20170629151200.GA16362@kroah.com>
Message-ID: <20170629184702.znzbc6i3gnccfegq@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Greg,

On Thu, Jun 29, 2017 at 05:12:00PM +0200, Greg KH wrote:
> On Mon, Jun 26, 2017 at 11:07:54AM +0200, Uwe Kleine-K?nig wrote:
> > this is v3 of the series that targets to consolidate parsing the rs485 specific
> > dt properties in a single place.
> 
> This patch breaks the build, and not all of them applied properly :(

sigh :( Sorry for the build breaker.

Regarding "doesn't apply": I tested to rebase on next/master (and so
tty-next) and it applies there just fine. I considered that good enough.
I guess you're talking about tty-testing?! I suggest to mention the
branch name you want to apply patches on in such mails.

There is a patch you applied on tty-testing that is not ok I think
("serial: imx-serial - move DMA buffer configuration to DT"). I
commented this one in the respective thread now.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
