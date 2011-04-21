From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 21 Apr 2011 10:23:28 +0200
Subject: [PATCH] omap: Run make savedefconfig on omap2plus_defconfig to
	shrink it
In-Reply-To: <20110421064423.GD13688@atomide.com>
References: <20110421064423.GD13688@atomide.com>
Message-ID: <20110421082328.GK31131@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2011 at 11:44:23PM -0700, Tony Lindgren wrote:
> This shrinks it down a bit more and makes it easier
> to patch later on.
Maybe pointing out why it's shrinkable would be nice.
E.g.

	After commit

		ffb63e3 (omap2/3/4: Select all omaps and boards by default

	many explicit settings can be dropped from the defconfig.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
