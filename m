From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 19 Nov 2018 22:36:29 +0800
Subject: [PATCH v2] ARM: dts: imx51-zii-rdu1: Remove EEPROM node
In-Reply-To: <1541872439-31531-1-git-send-email-festevam@gmail.com>
References: <1541872439-31531-1-git-send-email-festevam@gmail.com>
Message-ID: <20181119143627.GU5829@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 10, 2018 at 03:53:59PM -0200, Fabio Estevam wrote:
> The EEPROM under I2C2 was put by mistake in the dts.
> 
> Remove it as it is not really present on the real hardware.
> 
> Fixes: ceef0396f367 ("ARM: dts: imx: add ZII RDU1 board")
> Reported-by: Chris Healy <cphealy@gmail.com>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.
