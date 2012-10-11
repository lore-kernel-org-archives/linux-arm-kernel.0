From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 11 Oct 2012 15:49:16 +0800
Subject: [PATCH] ARM: dts: mxs: add the "clock-names" for gpmi-nand
In-Reply-To: <1349864829-19565-1-git-send-email-b32955@freescale.com>
References: <201210101237.13640.marex@denx.de>
 <1349864829-19565-1-git-send-email-b32955@freescale.com>
Message-ID: <20121011074912.GB26298@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2012 at 06:27:09PM +0800, Huang Shijie wrote:
> The current DT nodes for mx23/mx28 miss the `clocks-names` item for gpmi-nand.
> So the gpmi-nand driver could not find the proper clock.
> 
> This patch fixes this issue.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>

Applied, thanks.

Shawn
