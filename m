From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 17 Jun 2018 14:46:39 +0800
Subject: [PATCH v1] ARM: imx: add imx7d-m4
In-Reply-To: <20180405115134.8036-1-o.rempel@pengutronix.de>
References: <20180405115134.8036-1-o.rempel@pengutronix.de>
Message-ID: <20180617064638.GJ16091@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 05, 2018 at 01:51:34PM +0200, Oleksij Rempel wrote:
> Provide basic support for Cortex-M4 located on NXP iMX7D.
> This code was tested in combination with imx-rproc driver
> which will upload with specially formatted ELF image containing
> kernel, device and CPIO rootfs.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Can we make the patch subject a bit more complete, at least like
"ARM: imx: add imx7d-m4 support" or something?

Shawn
