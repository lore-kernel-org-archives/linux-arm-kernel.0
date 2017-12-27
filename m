From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 27 Dec 2017 09:09:44 -0200
Subject: [PATCH 1/2] ARM: dts: imx6: RDU2: disable internal watchdog
In-Reply-To: <20171227035656.4941-1-andrew.smirnov@gmail.com>
References: <20171227035656.4941-1-andrew.smirnov@gmail.com>
Message-ID: <CAOMZO5AGrJ0f64mLQyjpbiZWusT+J6Q39Rc6+aN-hxX8Xe=R8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrey,

On Wed, Dec 27, 2017 at 1:56 AM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> The system has an external watchdog in the environment processor
> so the internal watchdog is of no use.
>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: devicetree at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: cphealy at gmail.com
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Patch looks good.

Just not clear if the authorship comes from you or Lucas.

If Lucas is the original author then his name should appear in the From field.
