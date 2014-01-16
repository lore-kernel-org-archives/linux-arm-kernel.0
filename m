From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 16 Jan 2014 16:55:14 +0100
Subject: [PATCH v4 9/9] ARM: DTS: imx5* imx6*, use imx51-ssi
In-Reply-To: <1387545096-2334-10-git-send-email-mpa@pengutronix.de>
References: <1387545096-2334-1-git-send-email-mpa@pengutronix.de>
 <1387545096-2334-10-git-send-email-mpa@pengutronix.de>
Message-ID: <20140116155514.GA6464@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Fri, Dec 20, 2013 at 02:11:36PM +0100, Markus Pargmann wrote:
> imx51-ssi and imx21-ssi are different IPs. imx51-ssi supports online
> reconfiguration and needs this for correct interaction with SDMA. This
> patch adds imx51-ssi before each imx21-ssi for all imx5/imx6 SoCs.
> 

Mark Brown applied all other patches of this series. Could you please
take this one?

Thanks,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
