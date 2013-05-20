From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 20 May 2013 12:01:05 +0800
Subject: [PATCH v3 2/2] pinctrl: imx: add MVF600 support to imx pinctrl
 framework
In-Reply-To: <1368685224-17915-2-git-send-email-b35083@freescale.com>
References: <1368685224-17915-1-git-send-email-b35083@freescale.com>
 <1368685224-17915-2-git-send-email-b35083@freescale.com>
Message-ID: <20130520040103.GE25113@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 02:20:24PM +0800, Jingchang Lu wrote:
> On some platforms such as MVF600, offset of mux and pad ctrl register
> may be zero, and the mux_mode and config_val are in one 32-bit register.
> This patch adds support to imx core pinctrl framework to handle these
> cases.
> 
> Signed-off-by: Jingchang Lu <b35083@freescale.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
