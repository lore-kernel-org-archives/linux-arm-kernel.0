From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 16 Mar 2012 11:57:09 +0100
Subject: [PATCH v7 0/3] common clk framework
In-Reply-To: <1331878280-2758-1-git-send-email-mturquette@linaro.org>
References: <1331878280-2758-1-git-send-email-mturquette@linaro.org>
Message-ID: <20120316105709.GC29317@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2012 at 11:11:17PM -0700, Mike Turquette wrote:
> The common clock framework defines a common struct clk as well as an
> implementation of the clk api that unifies clock operations on various
> platforms and devices.
> 
> The net result is consolidation of many different struct clk definitions
> and platform-specific clock framework implementations.
> 
> This series is the feature freeze for the common clock framework.
> Unless any major bugs are reported this should be the final version of
> this patchset.  Now is the time to add any acked-by's, reviewed-by's or
> tested-by's.  I've carried over the *-by's from v6; I hope everyone is
> OK with that.

Nice work, thanks again Mike. I gave it a test on various i.MX SoCs and
I can give you my:

Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
