From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 15 May 2017 20:30:36 +0800
Subject: [PATCH 1/2] ARM: dts: imx6qdl-wandboard: Fix audio channel swap
In-Reply-To: <1494773451-11111-1-git-send-email-festevam@gmail.com>
References: <1494773451-11111-1-git-send-email-festevam@gmail.com>
Message-ID: <20170515123034.GT8471@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 14, 2017 at 11:50:50AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> When running a stress playback/stop loop test on a mx6wandboard channel
> swaps can be noticed randomly.
> 
> Increasing the SGTL5000 LRCLK pad strength to its maximum value fixes
> the issue, so add the 'lrclk-strength' property to avoid the audio
> channel swaps.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied both, thanks.
