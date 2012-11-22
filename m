From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 22 Nov 2012 14:32:17 -0200
Subject: [RFC] ARM: mx27: Replace clk_register_clkdev with clock DT lookup
In-Reply-To: <CAOMZO5BWhXSJSP_FFw69hOhcT7pt5JMqWMBZe3H7r1Yk105NEA@mail.gmail.com>
References: <1353532526-12897-1-git-send-email-festevam@gmail.com>
 <20121122075727.GX10369@pengutronix.de>
 <CAOMZO5BWhXSJSP_FFw69hOhcT7pt5JMqWMBZe3H7r1Yk105NEA@mail.gmail.com>
Message-ID: <CAOMZO5Bp46NuY9k_JGweW+QuYQqA4ngHP_1GWzFyWGhOYUtvHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2012 at 9:44 AM, Fabio Estevam <festevam@gmail.com> wrote:

> Thanks, this was the issue. It boots fine now.
>
> Will rebase against imx/soc and re-submit.

imx/soc does not build currently for imx_v4_v5_defconfig, so I will
wait until linux-next gets updated and rebase against it.

Regards,

Fabio Estevam
