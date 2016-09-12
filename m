From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Mon, 12 Sep 2016 11:09:56 -0400
Subject: [PATCH v5 3/3] clk: imx6: Fix procedure to switch the parent of
 LDB_DI_CLK
In-Reply-To: <CAOMZO5CPM9YfVqfpuyLmhGn9jC7p73Ocnc7LxE9=xA9ouawNQQ@mail.gmail.com>
References: <1468235521-3163-1-git-send-email-p.zabel@pengutronix.de>
 <1468235521-3163-3-git-send-email-p.zabel@pengutronix.de>
 <5787C558.5060904@gmail.com> <2499789.N9zTF3cNAV@diplodocus>
 <CAOMZO5CPM9YfVqfpuyLmhGn9jC7p73Ocnc7LxE9=xA9ouawNQQ@mail.gmail.com>
Message-ID: <CACrMeVA8CdL-Fqa4NwmBUPvzBXsi=o8bpB_tY2-Z0-xCoMX3xA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2016 at 7:13 AM, Fabio Estevam <festevam@gmail.com> wrote:
>
> Great news! It is good to know you are able to confirm this series
> fixes the LVDS issue on your board.
>
> Still interested to know if Novena LVDS still work with this series applied.
>
> Sean,Marek,
>
> Any chances of testing this series on Novena's board?
>
> Thanks

Hi Fabio, Shawn,

Advantech tested the v5 patch series on imx6q-b450v3 board (with 4.7
kernel) and confirmed the patch fixes the lvds blank display issue
being seen on some imx6q-b450v3 boards.

Details below:
With the patch applied:
Board # 1: 100 times power on/off, no LVDS display failure
Board # 2: 100 times power on/off, no LVDS display failure

Without the patch:
Board # 1: LVDS display failure (blank display output) at 4th time power on/off.
Board # 2: LVDS display failure (blank display output) at 3rd time power on/off.

Tested-by: Charles Kang <Charles.Kang@advantech.com.tw>

Since the patch has been reviewed and confirmed to fix display
failures on 2 different boards (imx6q-evi and imx6q-b450v3), can it be
applied?

Thanks,
Akshay
