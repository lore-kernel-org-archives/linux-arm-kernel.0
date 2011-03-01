From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 1 Mar 2011 23:31:45 +0000
Subject: [PATCH v2 2/4] ASoC: Fix burstsize and DSP_B format problems
	in imx-ssi.
In-Reply-To: <1298988128-11520-3-git-send-email-javier.martin@vista-silicon.com>
References: <1298988128-11520-1-git-send-email-javier.martin@vista-silicon.com>
	<1298988128-11520-3-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <20110301233145.GE2560@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 01, 2011 at 03:02:06PM +0100, Javier Martin wrote:
> When choosing IMX_DMA flag, burtsizes are set to its default
> value (0) which leads to driver malfunction. Change them to 4.
> 
> DSP_B interface needs additional flag to match DSP_B formats
> as described in several codecs as wm8741 and aic3205.
> 
> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>

Applied, thanks.
