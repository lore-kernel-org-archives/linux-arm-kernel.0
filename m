From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 15 Aug 2013 10:42:59 +0200
Subject: [PATCH] ARM: new platform for Energy Micro's EFM32 Cortex-M3 SoCs
In-Reply-To: <1376552964-16296-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1376552964-16296-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20130815084259.GG30496@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I forgot to mention that this patch depends on the following patches:

 - ARM: ARMv7-M: implement restart routine common to all v7-M machines
   sent with Message-Id: 1376494305-24270-1-git-send-email-u.kleine-koenig at pengutronix.de; and
 - clk: new driver for efm32 SoC
   sent with Message-Id: 1376510693-12491-1-git-send-email-u.kleine-koenig at pengutronix.de

So in the unlikely case you are already happy with this patch, it needs
some coordination to go in.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
