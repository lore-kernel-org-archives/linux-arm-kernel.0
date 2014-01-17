From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 17 Jan 2014 13:32:25 +0800
Subject: [PATCH v4 9/9] ARM: DTS: imx5* imx6*, use imx51-ssi
In-Reply-To: <20140116155514.GA6464@pengutronix.de>
References: <1387545096-2334-1-git-send-email-mpa@pengutronix.de>
 <1387545096-2334-10-git-send-email-mpa@pengutronix.de>
 <20140116155514.GA6464@pengutronix.de>
Message-ID: <20140117053223.GC1565@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 04:55:14PM +0100, Markus Pargmann wrote:
> Hi Shawn,
> 
> On Fri, Dec 20, 2013 at 02:11:36PM +0100, Markus Pargmann wrote:
> > imx51-ssi and imx21-ssi are different IPs. imx51-ssi supports online
> > reconfiguration and needs this for correct interaction with SDMA. This
> > patch adds imx51-ssi before each imx21-ssi for all imx5/imx6 SoCs.
> > 
> 
> Mark Brown applied all other patches of this series. Could you please
> take this one?

Can you please regenerate the patch against my for-next branch to get
imx50 SSI nodes covered as well?

Shawn
