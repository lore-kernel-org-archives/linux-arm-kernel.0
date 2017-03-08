From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 8 Mar 2017 15:01:35 +0100
Subject: [PATCH] ARM: dts: imx53-qsb: Constrain the TVE DAC voltage
In-Reply-To: <1486557231-8889-1-git-send-email-fabio.estevam@nxp.com>
References: <1486557231-8889-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <20170308140134.GC19934@x250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2017 at 10:33:51AM -0200, Fabio Estevam wrote:
> Quoting Philipp Zabel:
> "Since this regulator is used as the TVDAC analog power supply, this
> range should at least be limited to the analog power supply range of the
> TVDAC, listed in Table 74-9. of the i.MX53 reference manual (2.5-2.75V).
> 
> But since the nominal voltage is 2.75V, which was used to determine the
> analog gain that is supposed to result in the necessary 0.7V
> peak-to-peak amplitude on the VGA output, I'd say we should just fix the
> voltage to 2750000 here."
> 
> , so limit the TVDAC analog power supply as suggested.
> 
> Suggested-by: Lucas Stach <l.stach@pengutronix.de>
> Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
