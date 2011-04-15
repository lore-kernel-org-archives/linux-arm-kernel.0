From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 15 Apr 2011 22:11:07 +0200
Subject: [RFC PATCH] Consolidate SRAM support
In-Reply-To: <20110415130607.GM1611@n2100.arm.linux.org.uk>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
Message-ID: <20110415201107.GO31990@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2011 at 02:06:07PM +0100, Russell King - ARM Linux wrote:
> This is work in progress.
> 
> We have two SoCs using SRAM, both with their own allocation systems,
> and both with their own ways of copying functions into the SRAM.
I havn't checked the details, but maybe the code in
arch/arm/plat-mxc/iram_alloc.c could be migrated to your approach, too?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
