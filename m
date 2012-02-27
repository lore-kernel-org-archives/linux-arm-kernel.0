From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 27 Feb 2012 16:31:26 +0000
Subject: [GIT PULL] omap fixes for v3.3-rc4
In-Reply-To: <20120223231528.GE18185@atomide.com>
References: <20120223231528.GE18185@atomide.com>
Message-ID: <201202271631.27118.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 February 2012, Tony Lindgren wrote:
> Please pull omap fixes from:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes
> 
> This contains a fix for omap4 to call memblck_steal() from
> .reserve like it should be, and fixes a regression for smsc911x
> using boards as they now require regulators. Also included are
> fixes for errors that show up if the TWL PMIC is compiled as a
> module.
> 
> Note that the top two patches are from today: The smsc911x patch
> was updated for to remove an unnecessary variable, and the
> mailbox compile fix I applied earlier today.

Applied to fixes branch now. I first missed this pull request but
saw it now, sorry for the delay.

	Arnd
