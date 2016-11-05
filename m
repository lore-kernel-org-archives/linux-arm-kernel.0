From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 5 Nov 2016 16:19:02 +0800
Subject: [PATCH v2] ARM: dts: imx53-qsb: Fix regulator constraints
In-Reply-To: <1477580804-1423-1-git-send-email-fabio.estevam@nxp.com>
References: <1477580804-1423-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <20161105081901.GE5597@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2016 at 01:06:44PM -0200, Fabio Estevam wrote:
> Since commit fa93fd4ecc9c ("regulator: core: Ensure we are at least in
> bounds for our constraints") the imx53-qsb board populated with a Dialog
> DA9053 PMIC fails to boot:
> 
> LDO3: Bringing 3300000uV into 1800000-1800000uV
> 
> The LDO3 voltage constraints passed in the device tree do not match
> the valid range according to the datasheet, so fix this accordingly to
> allow the board booting again.
> 
> While at it, fix the other voltage constraints as well.
> 
> Cc: <stable@vger.kernel.org> # 4.7.x
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
