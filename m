From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 15 Jan 2017 13:09:40 +0000
Subject: [PATCH 3/4] iio: adc: add a driver for the SAR ADC found in
 Amlogic Meson SoCs
In-Reply-To: <0bfa97d1-2ee3-9dd9-dce3-593e93771f03@metafoo.de>
References: <20170111174334.24343-1-martin.blumenstingl@googlemail.com>
 <20170111174334.24343-4-martin.blumenstingl@googlemail.com>
 <0bfa97d1-2ee3-9dd9-dce3-593e93771f03@metafoo.de>
Message-ID: <3adef00d-aceb-029f-1f6a-0f6c71721559@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/01/17 12:26, Lars-Peter Clausen wrote:
> On 01/11/2017 06:43 PM, Martin Blumenstingl wrote:
>> +	indio_dev->name = dev_name(&pdev->dev);
> 
> The name is supposed to be the type of the device, e.g. part name, not the
> name of parent device instance. E.g. meson-gxbb-saradc or meson-gxl-saradc
> in this case.
Drat. I've been missing these again.  Somehow, never manage to get them
onto those things my eyes pick up whilst reviewing.

Thanks Lars,

Jonathan
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
