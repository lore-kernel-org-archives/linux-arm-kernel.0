From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 9 Aug 2016 14:20:00 +0800
Subject: [PATCH RESEND] ARM: i.MX6 Phytec PFLA02: Add supplies for the
 SoC internal regulators
In-Reply-To: <1468492234-4579-1-git-send-email-p.zabel@pengutronix.de>
References: <1468492234-4579-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20160809062000.GP4678@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 14, 2016 at 12:30:34PM +0200, Philipp Zabel wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> The SoC internal regulators for the CPU and the SoC come from the
> DA9063 vdd_core and vdd_soc. Add this relationship to the device tree
> so that the voltage drop on the SoC internal LDO regulators can be
> minimized.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Acked-by: Mark Brown <broonie@kernel.org>

Applied, thanks.
