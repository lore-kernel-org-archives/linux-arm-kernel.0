From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 20 Aug 2018 12:58:04 -0300
Subject: [PATCH] ARM: dts: imx7s-warp: enable i2c3 device support
In-Reply-To: <1534540997-20094-1-git-send-email-texier.pj2@gmail.com>
References: <1534540997-20094-1-git-send-email-texier.pj2@gmail.com>
Message-ID: <CAOMZO5BGN4182yz3VO9-iddqRWPsy8BA+y81Kgdybq0O36w1ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 17, 2018 at 6:23 PM, Pierre-Jean Texier
<texier.pj2@gmail.com> wrote:
> The WaRP7 has one mikroBUS socket on the back to plug click boards.
> This patch allows to interact with some of these
> i2c modules (EEPROM, RTC and so on).
>
> Signed-off-by: Pierre-Jean Texier <texier.pj2@gmail.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
