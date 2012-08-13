From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Aug 2012 23:04:53 +0800
Subject: [PATCH v2 2/2] ARM: imx/pcm043: add oftree support
In-Reply-To: <1344591170-13638-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1344591170-13638-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1344591170-13638-2-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20120813150450.GA27393@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 10, 2012 at 11:32:50AM +0200, Uwe Kleine-K?nig wrote:
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
> --
> changes since (implicit) v1
> (id:1343922986-32469-2-git-send-email-u.kleine-koenig at pengutronix.de)
> 
>  - add newlines between nodes
>  - adapt to changes in patch 1
> ---
>  arch/arm/boot/dts/phytec-pcm043.dtsi |   57 ++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 arch/arm/boot/dts/phytec-pcm043.dtsi
> 
Follow the imx dts naming pattern to name it imx35-phytec-pcm043.dtsi?

-- 
Regards,
Shawn
