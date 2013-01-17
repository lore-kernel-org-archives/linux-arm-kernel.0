From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 17 Jan 2013 15:38:56 +0100
Subject: [PATCH] sdma-imx: Add SDMA firmware for Freescale i.MX SOCs
In-Reply-To: <1358424987-22312-1-git-send-email-fabio.estevam@freescale.com>
References: <1358424987-22312-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20130117143856.GI8668@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Fabio,


On Thu, Jan 17, 2013 at 10:16:27AM -0200, Fabio Estevam wrote:
> Add SDMA firmware for Freescale i.MX SOCs.
great achievement that this is distributable finally! Thanks for your
effort.

One minor issue below.

> diff --git a/LICENCE.fsl_firmware b/LICENCE.fsl_firmware
> new file mode 100644
> index 0000000..a1fef32
> --- /dev/null
> +++ b/LICENCE.fsl_firmware
> @@ -0,0 +1,140 @@
> +FREESCALE SEMICONDUCTOR SOFTWARE LICENSE AGREEMENT 
> +
> +This is a legal agreement between you (either as an individual or as an
> +authorized representative of your employer) and Freescale
> +Semiconductor, Inc. ("Freescale"). It concerns your rights to use this
> +file and any accompanying written materials (the "Software"). In
> +consideration for Freescale allowing you to access the Software, you
> +are agreeing to be bound by the terms of this Agreement. If you do not
> +agree to all of the terms of this Agreement, do not download the
> +Software. If you change your mind later, stop using the Software and
> +delete all copies of the Software in your possession or control. Any
> +copies of the Software that you have already distributed, where
> +permitted, and do not destroy will continue to be governed by this
> +Agreement. Your prior use will also continue to be governed by this
> +Agreement.
> +
> +LICENSE GRANT.? Freescale grants to you, free of charge, the
What is this '?' about? 

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
