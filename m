From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 12 Apr 2017 10:38:27 -0300
Subject: [PATCH] serial: imx: Enable RTSD only when needed
In-Reply-To: <20170412133015.23185-1-romain.perier@collabora.com>
References: <20170412133015.23185-1-romain.perier@collabora.com>
Message-ID: <CAOMZO5Anz_C-pxPke_mqCtD_D9LBxTRWSk5fAZrr6KaMeMZGqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 12, 2017 at 10:30 AM, Romain Perier
<romain.perier@collabora.com> wrote:
> From: Nandor Han <nandor.han@ge.com>
>
> Currently, this IRQ is always enabled. Some devices might mux these pins
> to other I/Os, like I2C. This could lead to spurious interrupts.
>
> This commit makes this IRQ optional, by using the field have_rtscts.
>
> Signed-off-by: Nandor Han <nandor.han@ge.com>
> Signed-off-by: Romain Perier <romain.perier@collabora.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
