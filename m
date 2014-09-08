From: philippe.retornaz@gmail.com (=?ISO-8859-1?Q?Philippe_R=E9tornaz?=)
Date: Mon, 08 Sep 2014 09:42:35 +0200
Subject: [PATCH] mfd: mc13xxx: Configure WDI reset
In-Reply-To: <1410159671-25873-1-git-send-email-mpa@pengutronix.de>
References: <1410159671-25873-1-git-send-email-mpa@pengutronix.de>
Message-ID: <540D5DEB.6020605@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

Le 08/09/2014 09:01, Markus Pargmann a ?crit :
> Setup the PMIC to make a restart when a watchdog interrupt occures.
> If this is not configured, the PMIC will shut down the power supply
> without a restart.


Well, this was used to poweroff the mx31moboard board.
So we need to be able to configure the functionality.
