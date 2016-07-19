From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 19 Jul 2016 08:13:22 -0300
Subject: [PATCH v5 3/3] clk: imx6: Fix procedure to switch the parent of
 LDB_DI_CLK
In-Reply-To: <2499789.N9zTF3cNAV@diplodocus>
References: <1468235521-3163-1-git-send-email-p.zabel@pengutronix.de>
 <1468235521-3163-3-git-send-email-p.zabel@pengutronix.de>
 <5787C558.5060904@gmail.com> <2499789.N9zTF3cNAV@diplodocus>
Message-ID: <CAOMZO5CPM9YfVqfpuyLmhGn9jC7p73Ocnc7LxE9=xA9ouawNQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joshua,

On Sat, Jul 16, 2016 at 5:55 PM, Joshua Clayton
<stillcompiling@gmail.com> wrote:

> Took the printk out and the patch set still works as expected.
> ...so the previous email was a false alarm. Mea culpa
> Problem solved I think. Thanks Philipp!
>
> for my hardware (imx6q-evi) using xorg and  lvds
>
> Tested-by Joshua Clayton <stillcompiling@gmail.com>

Great news! It is good to know you are able to confirm this series
fixes the LVDS issue on your board.

Still interested to know if Novena LVDS still work with this series applied.

Sean,Marek,

Any chances of testing this series on Novena's board?

Thanks
