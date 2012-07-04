From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 4 Jul 2012 09:37:49 +0200
Subject: [PATCH 1/2] mfd: Add Freescale's PMIC MC34708 support
In-Reply-To: <1334853521-23792-1-git-send-email-paul.liu@linaro.org>
References: <1334853521-23792-1-git-send-email-paul.liu@linaro.org>
Message-ID: <20120704073749.GD5398@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Apr 20, 2012 at 12:38:40AM +0800, Ying-Chun Liu (PaulLiu) wrote:
> From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
> 
> Freescale MC34708 is a PMIC which supports the following features:
>  * 6 multi-mode buck regulators
>  * Boost regulator for USB OTG.
>  * 8 regulators for thermal budget optimization
>  * 10-bit ADC
>  * Real time clock
> 
> Signed-off-by: Robin Gong <B38343@freescale.com>
> Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
I want to push that forward. What is the state of these patches on your
end? Did you start to address the comments? Are there more recent
patches than the ones in this thread?

Whatever you might have it would be great if you could share it to help
preventing duplicate efforts.

Best regards and thanks in advance
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
