From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 10 Nov 2011 13:02:25 +0000
Subject: [V1] mfd: Convert pm860x to use regmap api
In-Reply-To: <1320925406-7445-1-git-send-email-jtzhou@marvell.com>
References: <1320925406-7445-1-git-send-email-jtzhou@marvell.com>
Message-ID: <20111110130225.GG21630@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2011 at 07:43:26PM +0800, Jett.Zhou wrote:
> Convert the register read/write code to use the register map API. We
> still need some pm860x specific code and locking in place to make sure
> test page read/write can not be interrupted by other i2c operation based
> on pm860x chip;

Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

I'm assuming that the interruptions come from the fact that there's two
I2C clients?

> Change-Id: I4d5c616d021ff62672477b9e08e118985c4d6af0

Don't include these in kernel submissions, they're only meaningful
within your private Gerrit install.
