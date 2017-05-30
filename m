From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 30 May 2017 15:12:04 -0300
Subject: [PATCH 2/2] net: phy: micrel: Restore led_mode and clk_sel on
 resume
In-Reply-To: <a8d0393c977b0d6fdab5d48ad13ca4d1ca893a07.1496164448.git.leonard.crestez@nxp.com>
References: <cover.1496164448.git.leonard.crestez@nxp.com>
 <a8d0393c977b0d6fdab5d48ad13ca4d1ca893a07.1496164448.git.leonard.crestez@nxp.com>
Message-ID: <CAOMZO5BzWQjxp656-x3zcj=VSOT2CfjJBVLNiPJaayCSejuUdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leonard,

On Tue, May 30, 2017 at 2:34 PM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:
> These bits seem to be lost after a suspend/resume cycle so just set them
> again.
>
> This patch fixes ethernet suspend/resume on imx6ul-14x14-evk boards.
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

When you send a v2 addressing Florian's comment, please make sure you
send it to David Miller (netdev maintainer).
