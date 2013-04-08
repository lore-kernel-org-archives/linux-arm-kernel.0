From: timur@tabi.org (Timur Tabi)
Date: Sun, 07 Apr 2013 21:50:19 -0500
Subject: [PATCH v2 06/11] ASoC: fsl-ssi: Setup generic imx dma params
In-Reply-To: <1365362721-3731-7-git-send-email-mpa@pengutronix.de>
References: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
 <1365362721-3731-7-git-send-email-mpa@pengutronix.de>
Message-ID: <5162306B.6090207@tabi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Markus Pargmann wrote:
> -		ret = of_property_read_u32_array(pdev->dev.of_node,
> -					"fsl,ssi-dma-events", dma_events, 2);

Does this mean that the "fsl,ssi-dma-events" property is no longer used?

-- 
Timur Tabi
