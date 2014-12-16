From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 16 Dec 2014 10:46:07 +0800
Subject: [PATCH] ARM: imx: pllv3: add shift for frequency multiplier
In-Reply-To: <1417539582-11387-1-git-send-email-stefan@agner.ch>
References: <1417539582-11387-1-git-send-email-stefan@agner.ch>
Message-ID: <20141216024605.GX2411@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 02, 2014 at 05:59:42PM +0100, Stefan Agner wrote:
> Add shift capabilties for the frequency multiplier (DIV_SELECT) to
> support Vybrid's USB PLL oddity. The PLL3 and PLL7 are the only
> PLL control registers which have the DIV_SELECT bit shifted by
> one. Be aware, there are known documentation errors in the
> reference manual too.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied, thanks.
