From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 24 Dec 2013 16:23:34 +0800
Subject: [PATCH] ARM: imx: improve status check of clock gate
In-Reply-To: <1387912887-6402-1-git-send-email-b20788@freescale.com>
References: <1387912887-6402-1-git-send-email-b20788@freescale.com>
Message-ID: <20131224082333.GH3872@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 24, 2013 at 02:21:27PM -0500, Anson Huang wrote:
> For ccm clock gate, both 2b'11 and 2b'01 should be treated
> as clock enabled, see below description in CCM, whenver CPU
> trys to check clock gate's status, system will be in run mode.
> 
> 2b'00: clock is off during all modes;
> 2b'01: clock is on in run mode, but off in wait and stop mode;
> 2b'10: Not applicable;
> 2b'11: clock is on during all modes, except stop mode.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>

Applied, thanks.
