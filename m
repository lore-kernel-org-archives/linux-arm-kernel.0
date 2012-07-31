From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 31 Jul 2012 16:40:26 +0100
Subject: [PATCH 1/1] ASoC: sgtl5000: enable VAG_POWER for LINE_IN
In-Reply-To: <1343387922-25227-1-git-send-email-b29396@freescale.com>
References: <1343387922-25227-1-git-send-email-b29396@freescale.com>
Message-ID: <20120731154026.GG4468@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2012 at 07:18:42PM +0800, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> LINE_IN also needs VAG_POWER on or we may hear noise when directly
> route LINE_IN to Headphone Mux.
> Tested on imx28evk.

Applied, thanks.
