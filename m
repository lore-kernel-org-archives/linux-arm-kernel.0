From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Tue, 12 Jan 2016 08:49:48 +0000
Subject: [PATCH v2 0/2] mfd: act8945a: add Active-semi ACT8945A PMIC MFD
 driver
In-Reply-To: <20160112084543.GP19803@x1>
References: <1452585915-551-1-git-send-email-wenyou.yang@atmel.com>
 <20160112084543.GP19803@x1>
Message-ID: <B256D81BAE5131468A838E5D7A243641D63E8931@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

> -----Original Message-----
> From: Lee Jones [mailto:lee.jones at linaro.org]
> Sent: 2016?1?12? 16:46
> To: Yang, Wenyou <Wenyou.Yang@atmel.com>
> Cc: Rob Herring <robh+dt@kernel.org>; Pawel Moll <pawel.moll@arm.com>;
> Mark Rutland <mark.rutland@arm.com>; Ian Campbell
> <ijc+devicetree@hellion.org.uk>; Kumar Gala <galak@codeaurora.org>; Javier
> Martinez Canillas <javier@dowhile0.org>; Krzysztof Kozlowski
> <k.kozlowski@samsung.com>; Ferre, Nicolas <Nicolas.FERRE@atmel.com>;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org
> Subject: Re: [PATCH v2 0/2] mfd: act8945a: add Active-semi ACT8945A PMIC
> MFD driver
> 
> On Tue, 12 Jan 2016, Wenyou Yang wrote:
> 
> > This patch set adds support for the Active-semi ACT8945A PMIC MFD
> > driver. It is a Multi Function Device with the following
> > subdevices:
> >  - Regulator
> >  - Charger
> >
> > It is interfaced to the host controller using I2C interface, ACT8945A
> > is a child device of the I2C.
> >
> > Changes in v2:
> >  - add more help information in Kconfig.
> >  - update the file header with short version license and author line.
> >  - remove unused structure members (dev, i2c_client) of stuct act8945a_dev.
> >  - use define "PLATFORM_DEVID_NONE" for mfd_add_devices(), instead of '-1'.
> >  - use more explicit info to indicate the failure to add sub devices.
> >  - remove the unnecessary print out.
> >  - substitute MODULE_LICENSE("GPL") for MODULE_LICENSE("GPL v2").
> >  - use more specific label in Example.
> >  - add pmic and charger nodes in Example.
> >
> > Wenyou Yang (2):
> >   mfd: act8945a: add Active-semi ACT8945A PMIC MFD driver
> >   mfd: add documentation for ACT8945A DT bindings
> 
> Sending out 3 patch-sets for related changes is a pretty unconventional way of
> doing things.  In future could you place them all in the same place, that way all of
> the patches stay together whist hopping around our inboxes.

Thank you for your advice, I will keep in mind next time.

> 
> >  Documentation/devicetree/bindings/mfd/act8945a.txt |   82 +++++++++++++++
> >  drivers/mfd/Kconfig                                |   11 ++
> >  drivers/mfd/Makefile                               |    1 +
> >  drivers/mfd/act8945a.c                             |  109 ++++++++++++++++++++
> >  include/linux/mfd/act8945a.h                       |   21 ++++
> >  5 files changed, 224 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/act8945a.txt
> >  create mode 100644 drivers/mfd/act8945a.c  create mode 100644
> > include/linux/mfd/act8945a.h
> >
> 
> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead Linaro.org ? Open source
> software for ARM SoCs Follow Linaro: Facebook | Twitter | Blog


Best Regards,
Wenyou Yang
