From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 28 Jun 2017 17:19:50 -0300
Subject: [PATCH] Modified imx7d-sdb.dts file so that VLDO4 provides 2.8V
 for MIPI CSI/DSI
In-Reply-To: <20170628174518.5950-1-mindentropy@gmail.com>
References: <20170628174518.5950-1-mindentropy@gmail.com>
Message-ID: <CAOMZO5A41QFoJsC2ST1kvpCOs3-unzHDrqXshHa=2ShWWCOyZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gautam,

On Wed, Jun 28, 2017 at 2:45 PM, mindentropy <mindentropy@gmail.com> wrote:
> From: Gautam Bhat <mindentropy@gmail.com>
>
>  * According to mx7sabresd schematics the MIPI CSI/DSI voltage rails
>    should be 2.8V but the voltage provided is a maximum of 3.3V and
>    minimum of 1.8V. Providing such a higher voltage might damage the
>    peripherals and violates the schematic settings.
>
> Signed-off-by: Gautam Bhat <mindentropy@gmail.com>

Patch looks good, but the Subject could be improved to something like:

ARM: dts: imx7d-sdb: Set LDO4 to 2.8V
