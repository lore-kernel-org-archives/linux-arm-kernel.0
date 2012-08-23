From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 23 Aug 2012 08:13:38 -0300
Subject: [PATCH v2] ARM: imx: add imx5x usb controller clock lookups
In-Reply-To: <1345719696-25738-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1345718328-6547-1-git-send-email-m.grzeschik@pengutronix.de>
 <1345719696-25738-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <CAOMZO5AV5eYgjuxAHBi-r1-kA4w2ue3kGVqYYG83d4=qxUxhDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

On Thu, Aug 23, 2012 at 8:01 AM, Michael Grzeschik
<m.grzeschik@pengutronix.de> wrote:
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
>  arch/arm/mach-imx/clk-imx51-imx53.c |   24 ++++++++++++++++++++++++

Just curious: does the current Chip Idea USB driver work 'as is' on mx5?

Are you also going to submit the <soc>.dtsi and <board>.dts patches?

I would like to try it on a mx53qsb.

Regards,

Fabio Estevam
