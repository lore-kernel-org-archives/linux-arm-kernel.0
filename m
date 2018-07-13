From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 13 Jul 2018 14:50:34 -0300
Subject: [PATCH v2 1/2] ARM: dts: imx51-zii-scu3-esb: Add switch IRQ line
 pinumx config
In-Reply-To: <20180713173005.19552-2-andrew.smirnov@gmail.com>
References: <20180713173005.19552-1-andrew.smirnov@gmail.com>
 <20180713173005.19552-2-andrew.smirnov@gmail.com>
Message-ID: <CAOMZO5BiSG2kRnTgda1ob5bP8-yhc7j0a5kndVcJMr=UwRaDjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2018 at 2:30 PM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> Instead of relying on default values, configure PAD_AUD3_BB_CK to be a
> GPIO explicitly. While at, it change the pad configuration to enable
> a 100K pull-down (the pin is used as IRQ_TYPE_LEVEL_HIGH).
>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: cphealy at gmail.com
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: devicetree at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
