From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 2 Nov 2017 20:45:21 +0530
Subject: [PATCH v5 6/7] i2c: davinci: switch to using gpiod for bus
 recovery gpios
In-Reply-To: <1509590430-11968-7-git-send-email-preid@electromag.com.au>
References: <1509590430-11968-1-git-send-email-preid@electromag.com.au>
 <1509590430-11968-7-git-send-email-preid@electromag.com.au>
Message-ID: <62ea3116-f909-2a80-dcd7-df03a82973bf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 November 2017 08:10 AM, Phil Reid wrote:
> Change the driver to use the gpio descriptors for the bus recovery
> information instead of the deprecated integer interface.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Phil Reid <preid@electromag.com.au>

Reviewed-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
