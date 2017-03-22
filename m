From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 22 Mar 2017 12:28:11 -0300
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select SMSC_PHY
In-Reply-To: <82d0aeeaed87ae5c9390b889cef4c54d715cde61.1490191972.git.leonard.crestez@nxp.com>
References: <82d0aeeaed87ae5c9390b889cef4c54d715cde61.1490191972.git.leonard.crestez@nxp.com>
Message-ID: <CAOMZO5CLH8pgdC7faTMSESW28Uu=soydN2m_yd26YuCE6u_yCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 11:27 AM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:
> The imx6sl-evk board has a LAN8720A ethernet phy supported by SMSC_PHY.
> Add this driver to the default imx config since the device is present on
> one of the evaluation boards.
>
> This used to work mostly fine with the generic phy driver but since
> commit 0878fff1f42c18e448ab5b8b4f6a3eb32365b5b6 that driver no longer

The prefer format when referring to a commit is:
0878fff1f42c  ("net: phy: Do not perform software reset for Generic PHY")

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
