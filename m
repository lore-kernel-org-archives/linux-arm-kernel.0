From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 29 Jan 2017 10:05:56 +0800
Subject: [PATCH] ARM: dts: imx53-qsb-common: fix FEC pinmux config
In-Reply-To: <20170125052548.27402-1-linux-kernel-dev@beckhoff.com>
References: <20170125052548.27402-1-linux-kernel-dev@beckhoff.com>
Message-ID: <20170129020554.GG5662@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2017 at 06:25:48AM +0100, linux-kernel-dev at beckhoff.com wrote:
> From: Patrick Bruenn <p.bruenn@beckhoff.com>
> 
> The pinmux configuration in device tree was different from manual
> muxing in <u-boot>/board/freescale/mx53loco/mx53loco.c
> All pins were configured as NO_PAD_CTL(1 << 31), which was fine as the
> bootloader already did the correct pinmuxing for us.
> But recently u-boot is migrating to reuse device tree files from the
> kernel tree, so it seems to be better to have the correct pinmuxing in
> our files, too.
> 
> Signed-off-by: Patrick Bruenn <p.bruenn@beckhoff.com>

Applied, thanks.
