From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 1 Jun 2010 19:05:28 +0100
Subject: [alsa-devel] [PATCH v2 1/4] imx-ssi.c: add new choices to
	platform configuration
In-Reply-To: <1274950737-26498-1-git-send-email-eric@eukrea.com>
References: <1274950737-26498-1-git-send-email-eric@eukrea.com>
Message-ID: <20100601180527.GC10031@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 27, 2010 at 10:58:54AM +0200, Eric B??nard wrote:
> * introduce 3 new flags to allow a more detailed configuration
> of the SSI link :
> 	IMX_SSI_NET : enable Network Mode
> 	IMX_SSI_SYN : enable Synchronous Mode
> 	IMX_SSI_USE_I2S_SLAVE : enable I2S Slave Mode
> * new platform can use these settings without breaking actual
> platforms.
> 
> Signed-off-by: Eric B??nard <eric@eukrea.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>

Sascha, any comments on the first couple of patches here?
