From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 19 Jun 2018 10:18:55 +0800
Subject: [PATCH] ARM: dts: imx6: RDU2: correct touchscreen axis inversion
In-Reply-To: <20180606093045.9215-1-l.stach@pengutronix.de>
References: <20180606093045.9215-1-l.stach@pengutronix.de>
Message-ID: <20180619021854.GW16091@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 06, 2018 at 11:30:45AM +0200, Lucas Stach wrote:
> The RMI4 touchscreen driver applied inversion and axis swap in the
> wrong order, violating the DT binding for those properties. This is
> fixed now, so correct the RDU2 DT to apply the inversion to the
> correct axis.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Applied, thanks.
