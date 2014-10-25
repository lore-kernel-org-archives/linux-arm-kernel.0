From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 25 Oct 2014 20:09:12 +0800
Subject: [PATCH RESEND] ARM: dts: imx28-evk: Let i2c0 run at 100kHz
In-Reply-To: <1413810481-22030-1-git-send-email-fabio.estevam@freescale.com>
References: <1413810481-22030-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20141025120910.GC3648@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 20, 2014 at 11:08:01AM -0200, Fabio Estevam wrote:
> Commit 78b81f4666fb ("ARM: dts: imx28-evk: Run I2C0 at 400kHz") caused issues
> when doing the following sequence in loop:
> 
> - Boot the kernel
> - Perform audio playback
> - Reboot the system via 'reboot' command
> 
> In many times the audio card cannot be probed, which causes playback to fail.
> 
> After restoring to the original i2c0 frequency of 100kHz there is no such
> problem anymore.
> 
> This reverts commit 78b81f4666fbb22a20b1e63e5baf197ad2e90e88.
> 
> Cc: <stable@vger.kernel.org> # 3.16+
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
