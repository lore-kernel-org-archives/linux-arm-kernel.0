From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 26 Dec 2017 15:51:07 +0800
Subject: [PATCH] ARM: dts: imx6q-h100: use usdhc2 VSELECT
In-Reply-To: <20171215092624.12806-1-m.tretter@pengutronix.de>
References: <20171215092624.12806-1-m.tretter@pengutronix.de>
Message-ID: <20171226075107.GC23070@X250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 15, 2017 at 10:26:24AM +0100, Michael Tretter wrote:
> The uSDHC controller directly provides a VSELECT signal that can be
> muxed to the external voltage select. Mux the VSELECT directly to avoid
> using a GPIO.
> 
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>

Applied, thanks.
