From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 6 Feb 2012 20:15:52 +0100
Subject: [PATCH 1/4] i2c/gpio-i2c add: add DT support
In-Reply-To: <4F301E25.5060507@samsung.com>
References: <1328438337-21185-1-git-send-email-plagnioj@jcrosoft.com>
 <4F301E25.5060507@samsung.com>
Message-ID: <20120206201552.153eba5d@endymion.delvare>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 06 Feb 2012 19:38:29 +0100, Karol Lewandowski wrote:
> On 05.02.2012 11:38, Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
> Hi!
> 
> > +Device-Tree bindings for i2c gpio driver
> > +
> > +Required properties:
> > +	- compatible = "gpio-i2c";
> 
> Driver name is "i2c-gpio" in file i2c-gpio.c. Previous version of patch 
> adding DT-support (prepared by Thomas Chou[1]) used i2c-gpio - could we 
> stick to that name?
> 
> [1] https://lkml.org/lkml/2011/2/23/584

Yes, please. The gpio subsystem normalized its driver names to gpio-*,
so we shouldn't use that anywhere else to avoid confusion.

-- 
Jean Delvare
