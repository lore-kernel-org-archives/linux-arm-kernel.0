From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 11 Apr 2012 09:24:02 +0100
Subject: [PATCH 01/40] clkdev: add clkname to struct clk_lookup
In-Reply-To: <20120411011149.GA20818@b20223-02.ap.freescale.net>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
 <1334065553-7565-2-git-send-email-s.hauer@pengutronix.de>
 <20120410143055.GT24211@n2100.arm.linux.org.uk>
 <20120410161142.GG3852@pengutronix.de>
 <20120411011149.GA20818@b20223-02.ap.freescale.net>
Message-ID: <20120411082401.GA32187@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 09:11:50AM +0800, Richard Zhao wrote:

> I don't like string loopup either. And after DT binding, we can use
> phandler to refer clk.

No, this is only useful on platforms that use DT.  This is a generic
Linux API so it needs to support architectures and platforms that don't
use DT as it's vanishingly unlikely that DT will ever be adopted by all
platforms.
