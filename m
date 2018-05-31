From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 30 May 2018 21:56:59 -0300
Subject: [PATCH 3/3] ARM: imx: remove i.MX6SLL support in i.MX6SL cpu idle
 driver
In-Reply-To: <AM3PR04MB13157285F0D882AD1C189617F5630@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1527664358-17844-1-git-send-email-Anson.Huang@nxp.com>
 <1527664358-17844-3-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5BYgPu_T=_x8JDkj=k6TUmP0QEQmT8qxoMfxzyTgZrF7g@mail.gmail.com>
 <AM3PR04MB13157285F0D882AD1C189617F5630@AM3PR04MB1315.eurprd04.prod.outlook.com>
Message-ID: <CAOMZO5BJzSHx4zmkMWZVR-Z-y6p-=bMG+WQ2LASOroEdXHdyLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anson,

On Wed, May 30, 2018 at 9:52 PM, Anson Huang <anson.huang@nxp.com> wrote:

>> The removal of this header file seems to be an unrelated change.
>
> This header file is no longer needed since no " cpu_is_imx6sl()" used in this file.

 cpu_is_imx6sl() is not defined inside arch/arm/mach-imx/hardware.h header file.
