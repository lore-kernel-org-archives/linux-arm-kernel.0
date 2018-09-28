From: aisheng.dong@nxp.com (A.s. Dong)
Date: Fri, 28 Sep 2018 13:47:59 +0000
Subject: [PATCH V7 0/3] soc: imx: add scu firmware api support
In-Reply-To: <20180928061223.dghtovm7kgcjhc4w@pengutronix.de>
References: <1537892878-30933-1-git-send-email-aisheng.dong@nxp.com>
 <20180928061223.dghtovm7kgcjhc4w@pengutronix.de>
Message-ID: <AM0PR04MB4211D4549496652DB54AE2C780EC0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

[...]

> On Wed, Sep 26, 2018 at 12:27:55AM +0800, Dong Aisheng wrote:
> > Unlike the former i.MX Architectures, the new generation i.MX8 SoCs
> > (e.g. MX8QXP and MX8QM) contain a system controller which runs on a
> > dedicated Cortex-M core to provide power, clock, Pad, and resource
> > management. Communication between the host processor running an OS
> and
> > the system controller happens through a SCU protocol.
> > This patchset adds the SCU APIs which is implemented based on MU and
> > will be used by different system components.
> >
> > It mainly consists of below parts:
> > 1) SCU IPC
> >    Basic IPC mechanism implemention based on mailbox which is used
> >    for communication between AP and SCU firmware.
> > 2) SCU IPC Service API
> 
> Still some imx_sc_ prefixes missing. Otherwise looks good to me now, so
> 
> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
> 

Appreciate your review work.
Will add the missing prefixes as well and re-send with you sign-off.
Thanks.

Regards
Dong Aisheng
