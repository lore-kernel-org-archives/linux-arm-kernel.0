From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 04 Jul 2011 18:48:17 +0400
Subject: [BUGFIX][PATCH] mach-mx5: fix the I2C clock parents
In-Reply-To: <1309787537-20664-1-git-send-email-LW@KARO-electronics.de>
References: <19985.49912.927038.73866@ipc1.ka-ro>
	<1309787537-20664-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <4E11D2B1.8030505@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lothar Wa?mann wrote:

> The clock from which the I2C timing is derived is the ipg_perclk not ipg_clk.

> I2C bus frequency was lower by a factor of ~8 due to the clock divider
> calculation being based on 66.5MHz IPG clock while the bus actually
> uses 8MHz ipg_perclk.

> Kernel version: 3.0.0-rc2 branch 'imx-for-next' of git://git.pengutronix.de/git/imx/linux-2.6

    Shouldn't this info be specified rather after the --- tear-line?

> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>

WBR, Sergei
