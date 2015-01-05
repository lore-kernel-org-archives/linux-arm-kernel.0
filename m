From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 5 Jan 2015 21:31:37 +0800
Subject: [PATCH V2] ARM: imx: remove unnecessary setting for DSM
In-Reply-To: <1418790199-12919-1-git-send-email-b20788@freescale.com>
References: <1418790199-12919-1-git-send-email-b20788@freescale.com>
Message-ID: <20150105133135.GF24511@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 17, 2014 at 12:23:19PM +0800, Anson Huang wrote:
> Now we support DSM in OCRAM for all i.MX6 SoCs,
> the resume entry point is set in asm code of
> suspend-imx6.S, so no need to set the resume
> entry point for SRC in pre-suspend flow.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>

Applied, thanks. 
