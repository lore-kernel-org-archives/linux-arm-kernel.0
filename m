From: anson.huang@nxp.com (Anson Huang)
Date: Mon, 2 Jul 2018 00:57:32 +0000
Subject: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
In-Reply-To: <CAOMZO5D8tjnjbwMdLGd7KF7_4PwqRWX8XH8kdcF3-5e-r2YQEA@mail.gmail.com>
References: <1529930051-14122-1-git-send-email-yibin.gong@nxp.com>
 <20180701093402.GN4348@dragon>
 <CAOMZO5BjOEGWv2dC-bp0BYHq+PhLssEKic+o7ock8_1Dobd=sQ@mail.gmail.com>
 <AM3PR04MB131507901BFEE1A5E426EECBF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5D8tjnjbwMdLGd7KF7_4PwqRWX8XH8kdcF3-5e-r2YQEA@mail.gmail.com>
Message-ID: <AM3PR04MB1315E7AED2BCE2265E6C443DF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Fabio

Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: Monday, July 2, 2018 8:55 AM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Robin Gong <yibin.gong@nxp.com>;
> Mark Rutland <mark.rutland@arm.com>; open list:OPEN FIRMWARE AND
> FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>;
> linux-kernel <linux-kernel@vger.kernel.org>; Rob Herring
> <robh+dt@kernel.org>; dl-linux-imx <linux-imx@nxp.com>; Sascha Hauer
> <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>;
> moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
> <linux-arm-kernel@lists.infradead.org>
> Subject: Re: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
> 
> Hi Anson,
> 
> On Sun, Jul 1, 2018 at 9:53 PM, Anson Huang <anson.huang@nxp.com> wrote:
> 
> > Yes, I think we can revert it to avoid breakage. Didn't notice that
> > some i.MX platform do NOT have those critical switches always-on.
> 
> Ok, thanks for confirming.
> 
> I will send a revert patch then.
> 
> Thanks
 
Just want to know how to handle such case? The kernel patch will never
be applied or is there any way to make kernel patch and dtb patch applied
together to avoid any breakage?

Anson.
