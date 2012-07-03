From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 3 Jul 2012 10:41:05 +0800
Subject: [PATCH v2 2/2] arm: mxs: enable flexcan on imx28
In-Reply-To: <1341219781-26107-3-git-send-email-mkl@pengutronix.de>
References: <1341219781-26107-1-git-send-email-mkl@pengutronix.de>
 <1341219781-26107-3-git-send-email-mkl@pengutronix.de>
Message-ID: <20120703024104.GC22106@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2012 at 11:03:01AM +0200, Marc Kleine-Budde wrote:
> As the flexcan driver has DT binding for some time now. This patch makes
> the flexcan driver available in the can drivers menu if a SOC with flexcan
> is enabled.
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Applied with subject prefix changed to "ARM: mxs: ..."

-- 
Regards,
Shawn
