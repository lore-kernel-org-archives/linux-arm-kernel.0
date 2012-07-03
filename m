From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 3 Jul 2012 10:36:47 +0800
Subject: [PATCH v2 1/2] arm: imx: enable flexcan on imx25, imx35, imx53,
 imx6q
In-Reply-To: <1341219781-26107-2-git-send-email-mkl@pengutronix.de>
References: <1341219781-26107-1-git-send-email-mkl@pengutronix.de>
 <1341219781-26107-2-git-send-email-mkl@pengutronix.de>
Message-ID: <20120703023644.GB22106@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2012 at 11:03:00AM +0200, Marc Kleine-Budde wrote:
> Aas the flexcan driver has DT binding for some time now. This patch makes
> the flexcan driver available in the can drivers menu if a SOC with flexcan
> is enabled.
> 
> Cc: Sascha Hauer <sha@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Applied with subject prefix changed to "ARM: imx: ..."

Regards,
Shawn
