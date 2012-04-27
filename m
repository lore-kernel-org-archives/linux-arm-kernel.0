From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 27 Apr 2012 11:44:03 +0800
Subject: [PATCH 1/2] ARM: imx6q-sabrelite.dts: Add SPI NOR support
In-Reply-To: <1335310537-11219-1-git-send-email-festevam@gmail.com>
References: <1335310537-11219-1-git-send-email-festevam@gmail.com>
Message-ID: <20120427034401.GE2234@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2012 at 08:35:36PM -0300, Fabio Estevam wrote:
> mx6qsabrelite has a sst25vf016b SPI NOR flash connected to eCSPI1.
> 
> Add support for it.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

One question below though:

I applied both patches and see the following modprobe error message
with my testing.  Any relevance, or I missed something?

spi_imx 2008000.ecspi: master is unqueued, this is deprecated
modprobe: FATAL: Could not load /lib/modules/3.4.0-rc4+/modules.dep: No such fil
e or directory

m25p80 spi32766.0: sst25vf016b (2048 Kbytes)
modprobe: FATAL: Could not load /lib/modules/3.4.0-rc4+/modules.dep: No such fil
e or directory

Regards,
Shawn
