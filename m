From: anson.huang@nxp.com (Anson Huang)
Date: Sun, 18 Mar 2018 02:25:00 +0000
Subject: [PATCH 2/2] regulator: pfuze100: update voltage setting for
 pfuze3000 sw1a
In-Reply-To: <CAOMZO5CUD373oZsnE69kEwj0oXLSQTMeb5k2YK6H5gPY7QyZPA@mail.gmail.com>
References: <1521269828-8874-1-git-send-email-Anson.Huang@nxp.com>
 <1521269828-8874-2-git-send-email-Anson.Huang@nxp.com>
 <1937778373.476574.1521290144753@email.1und1.de>
 <CAOMZO5CUD373oZsnE69kEwj0oXLSQTMeb5k2YK6H5gPY7QyZPA@mail.gmail.com>
Message-ID: <AM3PR04MB1315FFAB52CBB2E5DECED17BF5D50@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: Sunday, March 18, 2018 2:27 AM
> To: Stefan Wahren <stefan.wahren@i2se.com>
> Cc: Rob Herring <robh+dt@kernel.org>; Fabio Estevam
> <fabio.estevam@nxp.com>; Mark Rutland <mark.rutland@arm.com>; Robin
> Gong <yibin.gong@nxp.com>; Russell King - ARM Linux
> <linux@armlinux.org.uk>; Anson Huang <anson.huang@nxp.com>; Liam
> Girdwood <lgirdwood@gmail.com>; Shawn Guo <shawnguo@kernel.org>;
> Sascha Hauer <kernel@pengutronix.de>; Mark Brown <broonie@kernel.org>;
> open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> <devicetree@vger.kernel.org>; dl-linux-imx <linux-imx@nxp.com>; moderated
> list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
> <linux-arm-kernel@lists.infradead.org>; linux-kernel
> <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH 2/2] regulator: pfuze100: update voltage setting for
> pfuze3000 sw1a
> 
> Hi Stefan,
> 
> On Sat, Mar 17, 2018 at 9:35 AM, Stefan Wahren <stefan.wahren@i2se.com>
> wrote:
> > Hi Anson,
> >
> >> Anson Huang <Anson.Huang@nxp.com> hat am 17. M?rz 2018 um 07:57
> geschrieben:
> >>
> >>
> >> Latest pfuze3000 datasheet from:
> >>
> >>
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fcache.fr
> eescale.com%2Ffiles%2Fanalog%2Fdoc%2Fdata_sheet%2FPF3000.pdf%3Ffsrch
> %3D1%26sr%3D1%26pageNum%3D1&data=02%7C01%7CAnson.Huang%40nxp
> .com%7Cf6e1374a196741efe49b08d58c34bbab%7C686ea1d3bc2b4c6fa92cd99
> c5c301635%7C0%7C1%7C636569080479216580&sdata=DZQFb2hHbYqXjduHC0
> 1z%2FiAT4xvztN4Gy85S89mULwo%3D&reserved=0
> >
> > this link goes to Rev. 7.0, 9/2016, which isn't the latest one.
> >
> > I guess Rev. 9.0, 8/2017 is the latest.
> 
> You are right. This is the link to the latest datasheet:
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.n
> xp.com%2Fdocs%2Fen%2Fdata-sheet%2FPF3000.pdf&data=02%7C01%7CAnson
> .Huang%40nxp.com%7Cf6e1374a196741efe49b08d58c34bbab%7C686ea1d3bc
> 2b4c6fa92cd99c5c301635%7C0%7C1%7C636569080479216580&sdata=WIQYD
> 7WDn0%2FTl4BzM7oJdSuwK31Z64TfekeBAkou9XQ%3D&reserved=0

Yes, thank you for the reminder, I will update the commit message and the link in V2.
 
Anson.
