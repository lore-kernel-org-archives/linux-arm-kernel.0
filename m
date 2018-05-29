From: horms@verge.net.au (Simon Horman)
Date: Tue, 29 May 2018 10:57:11 +0200
Subject: [PATCH v2] arm64: dts: renesas: r8a77965: Add Watchdog Timer
 controller node using RCLK Watchdog Timer
In-Reply-To: <1527577262-8754-1-git-send-email-ykaneko0929@gmail.com>
References: <1527577262-8754-1-git-send-email-ykaneko0929@gmail.com>
Message-ID: <20180529085710.bwszso7ywiyvy5ld@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2018 at 04:01:02PM +0900, Yoshihiro Kaneko wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> 
> Add a device node for the Watchdog Timer (WDT) controller on the Renesas
> R-Car M3-N (R8A77965) SoC.
> 
> Based on a similar patch of the R8A7796 device tree
> by Geert Uytterhoeven <geert+renesas@glider.be>.
> 
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, applied.
