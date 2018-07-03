From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 3 Jul 2018 10:07:32 +0800
Subject: [PATCH 2/2] ARM: imx_v6_v7_defconfig: Select ULPI support
In-Reply-To: <20180703020236.GY4348@dragon>
References: <1529930043-6387-1-git-send-email-festevam@gmail.com>
 <1529930043-6387-2-git-send-email-festevam@gmail.com>
 <20180703020236.GY4348@dragon>
Message-ID: <20180703020731.GA4348@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 03, 2018 at 10:02:37AM +0800, Shawn Guo wrote:
> On Mon, Jun 25, 2018 at 09:34:03AM -0300, Fabio Estevam wrote:
> > From: Fabio Estevam <fabio.estevam@nxp.com>
> > 
> > Select CONFIG_USB_CHIPIDEA_ULPI and CONFIG_USB_ULPI_BUS so that
> > USB ULPI can be functional on some boards like imx51-babbge.
> > 
> > This fixes a kernel hang in 4.18-rc1 on i.mx51-babbage when
> > the bootloader does not initialize USB.
> > 
> > Suggested-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Applied this one as a fix.

Dropped for now, as I suspect that such selection should be done by
driver Kconfig as a dependency.

Shawn
