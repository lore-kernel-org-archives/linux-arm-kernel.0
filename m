From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 26 Sep 2016 08:36:50 +0200
Subject: [PATCH v2 2/4] ARM: dts: imx31: move CCM device node to AIPS2
 bus devices
In-Reply-To: <1474848223-19728-3-git-send-email-vz@mleia.com>
References: <1474848223-19728-1-git-send-email-vz@mleia.com>
 <1474848223-19728-3-git-send-email-vz@mleia.com>
Message-ID: <20160926063650.syqjgg445dny5kxw@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Vladimir,

On Mon, Sep 26, 2016 at 03:03:41AM +0300, Vladimir Zapolskiy wrote:
> i.MX31 Clock Control Module controller is found on AIPS2 bus, move it
> there from SPBA bus to avoid a conflict of device IO space mismatch.
> 
> Fixes: ef0e4a606fb6 ("ARM: mx31: Replace clk_register_clkdev with clock DT lookup")
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

out of interest: Which kind of machine do you work with? I assume this
isn't just a finger exercise with qemu?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
