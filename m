From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 4 Jul 2012 11:49:22 +0000
Subject: [GIT PULL] i.MX fixes for -rc
In-Reply-To: <20120704075116.GA29310@pengutronix.de>
References: <20120704075116.GA29310@pengutronix.de>
Message-ID: <201207041149.22941.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 July 2012, Sascha Hauer wrote:
> Hi Arnd, Olof,
> 
> Please pull the following i.MX fixes for -rc
> 

Thanks, pulled into the fixes branch. I plan to send out fixes tomorrow
to Linus.


> Uwe Kleine-K?nig (1):
>       ARM: imx: assert SCC gate stays enabled

Is this something that should have been marked for stable, or was
it just recently introduced? The description suggests the former.

	Arnd
