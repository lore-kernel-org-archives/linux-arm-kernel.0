From: aisheng.dong@nxp.com (A.s. Dong)
Date: Wed, 28 Feb 2018 02:27:57 +0000
Subject: [PATCH V4 2/2] thermal: imx: add i.MX7 thermal sensor support
In-Reply-To: <1519459369-29083-2-git-send-email-Anson.Huang@nxp.com>
References: <1519459369-29083-1-git-send-email-Anson.Huang@nxp.com>
 <1519459369-29083-2-git-send-email-Anson.Huang@nxp.com>
Message-ID: <AM3PR04MB306CAA99F88AE8F580422EF80C70@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Anson Huang [mailto:Anson.Huang at nxp.com]
> Sent: Saturday, February 24, 2018 4:03 PM
> To: rui.zhang at intel.com; edubezval at gmail.com; robh+dt at kernel.org;
> mark.rutland at arm.com; shawnguo at kernel.org; kernel at pengutronix.de;
> Fabio Estevam <fabio.estevam@nxp.com>; linux at armlinux.org.uk
> Cc: dl-linux-imx <linux-imx@nxp.com>; linux-pm at vger.kernel.org;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: [PATCH V4 2/2] thermal: imx: add i.MX7 thermal sensor support
> 
> This patch adds i.MX7 thermal sensor support, most of the i.MX7 thermal
> sensor functions are same with
> i.MX6 except the registers offset/layout, so we move those registers
> offset/layout definitions to soc data structure.
> 
> i.MX7 uses single calibration data @25C, the calibration data is located at
> OCOTP offset 0x4F0, bit[17:9], the formula is as below:
> 
> Tmeas = (Nmeas - n1) + 25; n1 is the fuse value for 25C.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Signed-off-by: Bai Ping <ping.bai@nxp.com>

Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng
