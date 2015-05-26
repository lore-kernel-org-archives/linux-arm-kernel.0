From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 26 May 2015 16:12:06 -0700
Subject: [PATCH 1/5] soc: mediatek: Add infracfg misc driver support
In-Reply-To: <1431372206-1237-2-git-send-email-s.hauer@pengutronix.de> (Sascha
 Hauer's message of "Mon, 11 May 2015 21:23:22 +0200")
References: <1431372206-1237-1-git-send-email-s.hauer@pengutronix.de>
 <1431372206-1237-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <7hfv6jorw9.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer <s.hauer@pengutronix.de> writes:

> This adds support for some miscellaneous bits of the infracfg controller.
> The mtk_infracfg_set/clear_bus_protection functions are necessary for
> the scpsys power domain driver to handle the bus protection bits which
> are contained in the infacfg register space.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

IMO, this feature still needs more documentation.  From an earlier
exchange with James Liao, he was able to get some more details from the
HW designer[1] which I think belong in comments somewhere in this
driver.

Kevin
 
[1] http://lists.infradead.org/pipermail/linux-mediatek/2015-March/000142.html
