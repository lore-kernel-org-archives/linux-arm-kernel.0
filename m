From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 5 Dec 2011 19:28:41 +0000
Subject: [PATCH v2 2/4] regulator: pass device_node to
 of_get_regulator_init_data()
In-Reply-To: <1322731268-12158-3-git-send-email-shawn.guo@linaro.org>
References: <1322731268-12158-1-git-send-email-shawn.guo@linaro.org>
 <1322731268-12158-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <20111205192841.GF7467@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2011 at 05:21:06PM +0800, Shawn Guo wrote:
> It's not always true that the device_node of regulator can be found
> at dev->of_node at the time when of_get_regulator_init_data() is being
> called, because in some cases the regulator nodes in device tree do
> not have 'struct device' behind them until regulator_dev gets created
> for it by core function regulator_register().

Applied, thanks.
