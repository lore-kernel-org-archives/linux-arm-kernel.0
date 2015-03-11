From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 11 Mar 2015 17:22:05 +0100
Subject: [PATCH] soc/tegra: move soc_device_register call out of arch/arm
In-Reply-To: <1425868301-22767-1-git-send-email-josephl@nvidia.com>
References: <1425868301-22767-1-git-send-email-josephl@nvidia.com>
Message-ID: <20150311162205.GK952@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 09, 2015 at 10:31:41AM +0800, Joseph Lo wrote:
> Expending the usage for both Tegra & Tegra64 SoCs.
Expanding? Mabe better: Moving this code to drivers/soc/tegra allows the
aarch64 SoCs to use it, too.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
