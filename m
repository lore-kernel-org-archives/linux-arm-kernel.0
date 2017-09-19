From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 19 Sep 2017 16:25:04 +0100
Subject: [PATCH v2 8/9] atmel_flexcom: Support backup mode
In-Reply-To: <53aa7783-0ecf-1e68-1bf9-c470ba2f79eb@microchip.com>
References: <20170915140411.31716-1-romain.izard.pro@gmail.com>
 <20170915140411.31716-9-romain.izard.pro@gmail.com>
 <53aa7783-0ecf-1e68-1bf9-c470ba2f79eb@microchip.com>
Message-ID: <20170919152504.nhp5i734u75gb5gq@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Sep 2017, Nicolas Ferre wrote:

> On 15/09/2017 at 16:04, Romain Izard wrote:
> > The controller used by a flexcom module is configured at boot, and left
> > alone after this. As the configuration will be lost after backup mode,
> > restore the state of the flexcom driver on resume.
> > 
> > Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> 
> Tested-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> On sama5d2 Xplained board (i2c0 from flexcom 4).
> and obviously:
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> Thanks Romain!
> 
> Regards,
> 
> > ---
> >  drivers/mfd/atmel-flexcom.c | 65 ++++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 50 insertions(+), 15 deletions(-)

This is the first time I've seen this patch.  Why's that?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
