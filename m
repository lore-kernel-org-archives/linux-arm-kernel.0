From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 17 Jul 2018 10:56:43 +0800
Subject: [PATCH] ARM: dts: imx51-zii-rdu1: Disable internal watchdog
In-Reply-To: <1531344867-898-1-git-send-email-festevam@gmail.com>
References: <1531344867-898-1-git-send-email-festevam@gmail.com>
Message-ID: <20180717025642.GB4576@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 06:34:27PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> imx51-zii-rdu1 has an external watchdog in the environment
> microcontroller, so disable the internal one.
> 
> This aligns with what was done in commit 7055f714032c ("ARM: dts:
> imx6: RDU2: disable internal watchdog") for imx6 rdu2 board.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
