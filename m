From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 19 Jul 2012 16:22:13 +0800
Subject: [PATCH 1/2] ARM: dts: add device tree source for imx6dl
In-Reply-To: <5007A74E.8010503@de.bosch.com>
References: <1337084027-19401-1-git-send-email-shawn.guo@linaro.org>
 <5007A74E.8010503@de.bosch.com>
Message-ID: <20120719082211.GA32439@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2012 at 08:21:02AM +0200, Dirk Behme wrote:
> On 15.05.2012 14:13, Shawn Guo wrote:
> >The imx6dl (i.MX6 DualLite) is a derivative of SoC imx6q, and it's
> >highly compatible with imx6q.  This patch renames imx6q.dtsi to
> >imx6.dtsi with some cosmetic changes, and split out the differences
> >between imx6dl and imx6q into imx6dl.dtsi and imx6q.dtsi respectively.
> >
> >Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> Ping. What's the status of this? Any plans to apply (an updated
> version of) this?
> 
Considering imx6sl (SoloLite) is on the way to come.  I would defer
the merging of this patch a little bit, otherwise we will need another
round of partitioning of the dts file to have the correct imx6.dtsi,
imx6q.dtsi, imx6dl.dtsi and imx6sl.dtsi.

-- 
Regards,
Shawn
