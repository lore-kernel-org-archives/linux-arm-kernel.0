From: anson.huang@nxp.com (Anson Huang)
Date: Wed, 3 Jan 2018 02:09:11 +0000
Subject: [PATCH 1/2] ARM: dts: imx6ul: add 696MHz operating point
In-Reply-To: <CAOMZO5BGmnNzv7YobtB+KOi0PM+qzyYi97q_NZtT1PU_e+Bcbg@mail.gmail.com>
References: <1514912859-17691-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5C-qgyCJPBHYwjD9zjHqu4eoGDfoB5-BcFdnvSy01MKiQ@mail.gmail.com>
 <E5B0DB53-D0E5-430B-BBCC-EF3899C70DAE@nxp.com>
 <CAOMZO5BGmnNzv7YobtB+KOi0PM+qzyYi97q_NZtT1PU_e+Bcbg@mail.gmail.com>
Message-ID: <AM3PR04MB13157F7EFCEEFE030104C87DF51E0@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Post this discussion mail to kernel mail list, since last mail is rejected due to incorrect format, sorry for confusion. 

Best Regards!
Anson Huang


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: 2018-01-02 11:32 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE <linux-
> arm-kernel at lists.infradead.org>; open list:OPEN FIRMWARE AND FLATTENED
> DEVICE TREE BINDINGS <devicetree@vger.kernel.org>; linux-
> pm at vger.kernel.org; linux-kernel <linux-kernel@vger.kernel.org>; Mark
> Rutland <mark.rutland@arm.com>; A.s. Dong <aisheng.dong@nxp.com>; Jacky
> Bai <ping.bai@nxp.com>; viresh kumar <viresh.kumar@linaro.org>;
> rjw at rjwysocki.net; Russell King - ARM Linux <linux@armlinux.org.uk>; Rob
> Herring <robh+dt@kernel.org>; Sascha Hauer <kernel@pengutronix.de>;
> Fabio Estevam <fabio.estevam@nxp.com>; Shawn Guo
> <shawnguo@kernel.org>
> Subject: Re: [PATCH 1/2] ARM: dts: imx6ul: add 696MHz operating point
> 
> On Tue, Jan 2, 2018 at 1:12 PM, Anson Huang <anson.huang@nxp.com> wrote:
> 
> > There is a comment in VDD_ARM, VDD_SOC must NOT lower than VDD_ARM.
> >
> > Output voltage must be set to the following rules:
> > ? VDD_ARM_CAP <= VDD_SOC_CAP
> > ? VDD_SOC_CAP - VDD_ARM_CAP < 330 mV
> 
> Thanks for the clarifcation.
> 
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
