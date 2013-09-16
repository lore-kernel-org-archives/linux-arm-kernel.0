From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 16 Sep 2013 17:24:45 +0800
Subject: [PATCH] ARM: dts: imx6q: fix the wrong offset of the Pad Mux
 register
In-Reply-To: <1379322165-2511-1-git-send-email-b32955@freescale.com>
References: <1379322165-2511-1-git-send-email-b32955@freescale.com>
Message-ID: <20130916092444.GN31147@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 16, 2013 at 05:02:45PM +0800, Huang Shijie wrote:
> The patch "0b7a76a ARM: dts: imx6q{dl}: add DTE pads for uart"
> adds the DTE pads for uart. For PAD_EIM_D29, the offset of the
> Pad Mux register should be 0x0c8, not 0x0c4.
> 
> This patch fixes it.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>

Applied, thanks.

Shawn
