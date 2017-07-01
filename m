From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 1 Jul 2017 09:41:33 -0300
Subject: [PATCH v2] ARM: dts: imx7d-sdb: Set VLDO4 outpt to 2.8V for MIPI
 CSI/DSI
In-Reply-To: <20170701073911.7338-1-mindentropy@gmail.com>
References: <CAOMZO5A41QFoJsC2ST1kvpCOs3-unzHDrqXshHa=2ShWWCOyZg@mail.gmail.com>
 <20170701073911.7338-1-mindentropy@gmail.com>
Message-ID: <CAOMZO5BQAigAsPCmzz-b-3wH9eaTmHp=B=d1cxq10pDLOcdsxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 1, 2017 at 4:39 AM, mindentropy <mindentropy@gmail.com> wrote:
> From: Gautam Bhat <mindentropy@gmail.com>
>
>  * According to mx7sabresd schematics the MIPI CSI/DSI voltage rails
>    should be 2.8V but the voltage provided is a maximum of 3.3V and
>    minimum of 1.8V. Providing such a higher voltage might damage the
>    peripherals and violates the schematic settings.
>
> Signed-off-by: Gautam Bhat <mindentropy@gmail.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
