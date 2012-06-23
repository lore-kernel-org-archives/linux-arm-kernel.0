From: marex@denx.de (Marek Vasut)
Date: Sat, 23 Jun 2012 20:47:32 +0200
Subject: [PATCH 1/2 V3] MXS: Set I2C timing registers for mxs-i2c
In-Reply-To: <1339242351-8797-1-git-send-email-marex@denx.de>
References: <1339242351-8797-1-git-send-email-marex@denx.de>
Message-ID: <201206232047.33228.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> This patch configures the I2C bus timing registers according
> to information passed via DT. Currently, 100kHz and 400kHz
> modes are supported.
[...]

Is there any reason why this can not be merged other than the timing registers 
goo (which I believe shall stay as in the datasheet until we figure out if it's 
even reasonable to add some computation there).

Best regards,
Marek Vasut
