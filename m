From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 20 Dec 2011 11:55:40 +0000
Subject: [PATCH 10/12] ASoC: mxs-saif: convert to clk_prepare/clk_unprepare
In-Reply-To: <1324382443-4439-11-git-send-email-shawn.guo@linaro.org>
References: <1324382443-4439-1-git-send-email-shawn.guo@linaro.org>
 <1324382443-4439-11-git-send-email-shawn.guo@linaro.org>
Message-ID: <20111220115540.GN2866@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2011 at 08:00:41PM +0800, Shawn Guo wrote:
> The patch converts mxs-saif driver to clk_prepare/clk_unprepare by
> using helper functions clk_prepare_enable/clk_disable_unprepare.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
