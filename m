From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Jun 2014 09:32:04 +0100
Subject: [PATCH v2 06/10] mfd: Add driver for Maxim 77802 Power
 Management IC
In-Reply-To: <53A01F09.5070106@collabora.co.uk>
References: <1402941758-11216-1-git-send-email-javier.martinez@collabora.co.uk>
 <1402941758-11216-7-git-send-email-javier.martinez@collabora.co.uk>
 <20140616192720.GK5099@sirena.org.uk>
 <53A01F09.5070106@collabora.co.uk>
Message-ID: <20140618083204.GP21030@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> +config MFD_MAX77802
> >> +	tristate "Maxim Integrated MAX77802 PMIC Support"
> >> +	depends on I2C=y
> >> +	select MFD_CORE
> >> +	select REGMAP_I2C
> >> +	select REGMAP_IRQ
> >> +	select IRQ_DOMAIN
> >> +	help
> >> +	  Say yes here to support for Maxim Integrated MAX77802.
> >> +	  This is a Power Management IC with RTC on chip.
> >> +	  This driver provides common support for accessing the device;
> >> +	  additional drivers must be enabled in order to use the functionality
> >> +	  of the device.
> >> +
> > 
> > It is a bit unorthodox to put the build infrastructure in the same patch
> > as the DT binding...
> > 
> 
> I thought it was the opposite. That a DT binding document has to be added along
> with the first user of the binding but I'll separate the DT doc in another patch
> then if that is the right thing to do.

This was the 'old' method, but changed a little over a year ago.

> Thanks a lot for all your suggestions, I'll wait a little to see if there is
> more feedback and repost a v3 addressing all the issues you pointed out.

Just re-post it.  I'll review the next version.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
