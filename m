From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 29 May 2013 14:06:02 +0800
Subject: [PATCH RESEND v3 1/2] pinctrl: imx: add VF610 support to imx
 pinctrl framework
In-Reply-To: <1369733528-25926-1-git-send-email-b35083@freescale.com>
References: <1369733528-25926-1-git-send-email-b35083@freescale.com>
Message-ID: <20130529060600.GG370@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 28, 2013 at 05:32:07PM +0800, Jingchang Lu wrote:
> On some platforms such as VF610, offset of mux and pad ctrl register
> may be zero, and the mux_mode and config_val are in one 32-bit register.
> This patch adds support to imx core pinctrl framework to handle these
> cases.
> 
> Signed-off-by: Jingchang Lu <b35083@freescale.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
