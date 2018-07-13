From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 13 Jul 2018 14:50:54 -0300
Subject: [PATCH v2 2/2] ARM: dts: imx51-zii-scu3-esb: Fix RAVE SP watchdog
 compatible string
In-Reply-To: <20180713173005.19552-3-andrew.smirnov@gmail.com>
References: <20180713173005.19552-1-andrew.smirnov@gmail.com>
 <20180713173005.19552-3-andrew.smirnov@gmail.com>
Message-ID: <CAOMZO5ADn2FdZ+4uOV-K_vD+cLxd3a25Dbttbe7XLkB=u=6Dpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2018 at 2:30 PM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> It looks like I made a nasty typo in the original patch which resulted
> in missing watchdog device. Fix it.
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
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
