From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Thu, 27 May 2010 14:49:07 +0100
Subject: [alsa-devel] [PATCH v2 1/4] imx-ssi.c: add new choices to
	platform configuration
In-Reply-To: <1274950737-26498-1-git-send-email-eric@eukrea.com>
References: <1274950737-26498-1-git-send-email-eric@eukrea.com>
Message-ID: <1274968147.3542.282.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-05-27 at 10:58 +0200, Eric B?nard wrote:
> * introduce 3 new flags to allow a more detailed configuration
> of the SSI link :
> 	IMX_SSI_NET : enable Network Mode
> 	IMX_SSI_SYN : enable Synchronous Mode
> 	IMX_SSI_USE_I2S_SLAVE : enable I2S Slave Mode
> * new platform can use these settings without breaking actual
> platforms.
> 
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@slimlogic.co.uk>
> ---

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
