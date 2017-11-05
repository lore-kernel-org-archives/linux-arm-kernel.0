From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 5 Nov 2017 16:24:04 +0100
Subject: [PATCH] ARM: dts: vf610-zii-dev-rev-c: Fix the I2C EEPROM address
In-Reply-To: <1509884312-4499-1-git-send-email-festevam@gmail.com>
References: <1509884312-4499-1-git-send-email-festevam@gmail.com>
Message-ID: <20171105152404.GZ24320@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 05, 2017 at 10:18:32AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> at24mac602 should be at the I2C address 0x50, so that it matches the
> 'reg' property.
> 
> Fixes: d4cd158176c3 ("ARM: dts: vf610-zii-dev: Add .dts file for rev. C")
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
