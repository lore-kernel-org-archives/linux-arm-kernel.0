From: guenter.roeck@ericsson.com (Guenter Roeck)
Date: Tue, 19 Oct 2010 07:52:20 -0700
Subject: [PATCH 1/2] hwmon: add generic GPIO fan driver
In-Reply-To: <20101019114636.GF29120@kw.sim.vm.gnt>
References: <20101017154021.GB29120@kw.sim.vm.gnt>
	<1287330612-11256-1-git-send-email-simon@sequanux.org>
	<20101018160830.GB9033@ericsson.com>
	<20101018203610.GD29120@kw.sim.vm.gnt>
	<20101018205034.GA10473@ericsson.com>
	<20101019114636.GF29120@kw.sim.vm.gnt>
Message-ID: <20101019145220.GA13908@ericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon.

On Tue, Oct 19, 2010 at 07:46:36AM -0400, Simon Guinot wrote:

> Hi Guenter,
[ ... ]
> > It probably does. Wonder what it actually shows. Can you check ?
> 
> If CONFIG_PRINTK is enabled, dev_info() end up in a dev_printk() call
> with the level argument set to KERN_INFO.
> The message format is:
> ${driver_name} ${device_name}: ${message}
> 
> Note that the device id number is part of the device name. So, if two
> gpio-fan devices are initialized, you will see:
> 
> gpio-fan gpio-fan.0: GPIO fan initialized
> gpio-fan gpio-fan.1: GPIO fan initialized
> 
> For a single fan device, you will see:
> 
> gpio-fan gpio-fan: GPIO fan initialized
> 
Ok, guess that is all we can ask for.

Thanks,
Guenter
