From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 1 Jul 2018 10:55:14 +0800
Subject: [PATCH] ARM: dts: imx7d-sdb: Restore pwm backlight support
In-Reply-To: <c328d3e13702fa624febe08d7cd68df5b82b8c30.1529490998.git.leonard.crestez@nxp.com>
References: <c328d3e13702fa624febe08d7cd68df5b82b8c30.1529490998.git.leonard.crestez@nxp.com>
Message-ID: <20180701025513.GD4348@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2018 at 01:41:16PM +0300, Leonard Crestez wrote:
> This was removed in commit 5eaeaccdaedb ("ARM: dts: imx7d-sdb: Pass
> 'enable-gpios' and 'power-supply' properties") with a note claiming that
> GPIO1_IO01 is connected to a pin labeled as "PWREN" on the connector.
> 
> Despite that label this pin does actually work as a PWM controlling
> brightness. So restore pwm functionality.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Applied, thanks.
