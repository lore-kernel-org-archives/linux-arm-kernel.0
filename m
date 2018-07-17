From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 17 Jul 2018 15:27:00 +0800
Subject: [PATCH] ARM: dts: imx6ul-pico-hobbit: Do not hardcode the memory
 size
In-Reply-To: <1531793325-12639-1-git-send-email-festevam@gmail.com>
References: <1531793325-12639-1-git-send-email-festevam@gmail.com>
Message-ID: <20180717072658.GN4576@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2018 at 11:08:45PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> There are two variants of imx6ul-pico boards: one with 256MB and
> another one with 512MB of RAM.
> 
> Do not hardcode the memory size in the device tree and let the
> bootloader fill the correct value instead.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
