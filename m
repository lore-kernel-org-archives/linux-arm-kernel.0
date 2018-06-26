From: anson.huang@nxp.com (Anson Huang)
Date: Tue, 26 Jun 2018 01:06:40 +0000
Subject: [PATCH] ARM: dts: imx6sll-evk: make pfuze100 sw4 always on
In-Reply-To: <CAOMZO5Coi-LRXG8vepnm-eSSx75LLEtsZ90WrtK6rEy76u+OBQ@mail.gmail.com>
References: <1529648932-4832-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5Coi-LRXG8vepnm-eSSx75LLEtsZ90WrtK6rEy76u+OBQ@mail.gmail.com>
Message-ID: <AM3PR04MB13157D44DC7357CFB2F35948F5490@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Fabio

Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: Monday, June 25, 2018 8:23 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <s.hauer@pengutronix.de>; Sascha Hauer <kernel@pengutronix.de>; Fabio
> Estevam <fabio.estevam@nxp.com>; Rob Herring <robh+dt@kernel.org>;
> Mark Rutland <mark.rutland@arm.com>; open list:OPEN FIRMWARE AND
> FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>;
> dl-linux-imx <linux-imx@nxp.com>; moderated list:ARM/FREESCALE IMX / MXC
> ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; linux-kernel
> <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH] ARM: dts: imx6sll-evk: make pfuze100 sw4 always on
> 
> Hi Anson,
> 
> On Fri, Jun 22, 2018 at 3:28 AM, Anson Huang <Anson.Huang@nxp.com>
> wrote:
> > On i.MX6SLL EVK board, PFuze100's SW4 is supplying LPDDR3, it needs to
> > be always on. This patch fixes Linux kernel boot up hang caused by SW4
> > being turned
> > off:
> >
> > [    1.693613] cfg80211: failed to load regulatory.db
> > [    1.700063] SW4: disabling
> > [    1.703973] SWBST: disabling
> 
> It would be nice to mention in the commit log what was the patch that caused
> the breakage, just like Robin did for imx6sl-evk.
> 
> Thanks,
 
Done, already sent out V2 patch, please review it, thanks.

Anson.
