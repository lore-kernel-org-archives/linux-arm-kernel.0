From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 10 Mar 2014 13:14:49 +0800
Subject: [PATCH v3] ARM: dts: vf610-twr: Add support for sdhc1
In-Reply-To: <1394124034-21452-1-git-send-email-cosminstefan.stoica@freescale.com>
References: <1394124034-21452-1-git-send-email-cosminstefan.stoica@freescale.com>
Message-ID: <20140310051446.GE15218@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 06, 2014 at 06:40:34PM +0200, Stoica Cosmin Stefan wrote:
> From: Cosmin Stoica <cosminstefan.stoica@freescale.com>
> 
> The kernel was not able to boot from SD card because sdhc support
> was not present into the dts.
> 
> A new entry for sdhc1 was added for vf610-twr board based on the
> compatible entry present on imx53.
> 
> After applying these changes, the kernel is able to boot successfully
> from SD card.
> 
> Changes v2-v3:
> Use tabs instead of spaces for identaion
> Changes according to Shawn Guo's comments:
> - rebased on Shawn Guo's latest for-next tree
> - remove EOL at EOF
> 
> Changes v1-v2:
> According to Shawn Guo's comments:
> - moved esdhc1 node before fec0 in board dts file;
> - reformatted clocks line;
> - removed duplicate property (bus-width) in dtsi file.
> 
> Signed-off-by: Cosmin Stoica <cosminstefan.stoica@freescale.com>
> Signed-off-by: Chircu Bogdan <Bogdan.Chircu@freescale.com>
> Signed-off-by: Eddy Petrisor <eddy.petrisor@freescale.com>

Applied, thanks.
