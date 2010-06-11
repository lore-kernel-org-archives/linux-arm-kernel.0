From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 11 Jun 2010 08:37:33 +0200
Subject: [PATCH 4/5] [ARM] Auto calculate ZRELADDR and provide option
	for exceptions
In-Reply-To: <AANLkTiltifSEFdpXB0avw4ZyDzP_IrDpipafBAJbN17U@mail.gmail.com>
References: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
	<1275550613-9553-5-git-send-email-eric.miao@canonical.com>
	<AANLkTiltifSEFdpXB0avw4ZyDzP_IrDpipafBAJbN17U@mail.gmail.com>
Message-ID: <20100611063733.GB10894@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Linus,

On Fri, Jun 11, 2010 at 12:17:44AM +0200, Linus Walleij wrote:
> I assume it should be submitted simultaneously with a patch nuking off
> all Makefile.boot files and that infrastructure then?
Only when bootp is deleted or fixed not to use these variables.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
