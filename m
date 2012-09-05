From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 5 Sep 2012 07:41:07 +0100
Subject: [PATCH 3/3] i2c: nomadik: Add Device Tree support to the Nomadik
 I2C driver
In-Reply-To: <CACRpkdZESujO=2BU3jeKiX3Cm+JY2UPEXwGkro75FWa5Gio5YQ@mail.gmail.com>
References: <20120831122323.GC5962@gmail.com> <5044C82E.5060207@gmail.com>
 <20120903152012.GH31163@gmail.com>
 <201209041428.21409.arnd@arndb.de>
 <CACRpkdZESujO=2BU3jeKiX3Cm+JY2UPEXwGkro75FWa5Gio5YQ@mail.gmail.com>
Message-ID: <20120905064106.GA4233@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 04, 2012 at 07:27:10PM +0200, Linus Walleij wrote:
> On Tue, Sep 4, 2012 at 4:28 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > In this particular case, we don't have a single board file providing a
> > struct nmk_i2c_controller definition for platform data, so the best way
> > to handle this IMHO is to remove the header file with the platform
> > data definition, and just encode the defaults in the driver.
> 
> Alessandro Rubini is actively working on bridging this (and
> other amba_device primecells) to PCI, that is the reason why it
> was recently converted to an amba_device. How is he then supposed to
> get the proper parameters into the driver? Note that the PCI ID
> is no help at all since the parameters depend on what is connected
> to the I2C bus, not on what it itself is connected to. Isn't platform data
> used in such cases?

So why can't Alessandro continue to use Platform Data in the normal way?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
