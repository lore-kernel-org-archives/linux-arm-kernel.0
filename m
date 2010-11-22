From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 22 Nov 2010 11:42:47 +0000
Subject: [PATCH 2/3] ASoC: add iPAQ hx4700 machine driver
In-Reply-To: <1290257964-17435-3-git-send-email-mad_soft@inbox.ru>
References: <1290257964-17435-1-git-send-email-mad_soft@inbox.ru>
	<1290257964-17435-3-git-send-email-mad_soft@inbox.ru>
Message-ID: <20101122114247.GB15156@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 20, 2010 at 03:59:23PM +0300, Dmitry Artamonow wrote:
> AK4641 connected via I2S and I2C, jack detection via GPIO.
> 
> Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
> Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>

This looks OK but depends on the CODEC driver.
