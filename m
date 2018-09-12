From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 12 Sep 2018 14:45:51 +0800
Subject: [PATCH v2] ARM: dts: imx53-qsb: disable 1.2GHz OPP
In-Reply-To: <20180912062301.3972-1-s.hauer@pengutronix.de>
References: <20180910125056.30813-1-s.hauer@pengutronix.de>
 <20180912062301.3972-1-s.hauer@pengutronix.de>
Message-ID: <20180912064548.GB28239@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2018 at 08:23:01AM +0200, Sascha Hauer wrote:
> The maximum CPU frequency for the i.MX53 QSB is 1GHz, so disable the
> 1.2GHz OPP. This makes the board work again with configs that have
> cpufreq enabled like imx_v6_v7_defconfig on which the board stopped
> working with the addition of cpufreq-dt support.
> 
> Fixes: 791f416608 ("ARM: dts: imx53: add cpufreq-dt support")
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Applied, thanks.
