From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Fri, 10 Nov 2017 18:12:09 +0200
Subject: [PATCH v5 4/7] i2c: designware: add i2c gpio recovery option
In-Reply-To: <7abe16b1-4bfd-4427-8783-b3733ed9f06c@electromag.com.au>
References: <1509590430-11968-1-git-send-email-preid@electromag.com.au>
 <1509984581.25007.47.camel@linux.intel.com>
 <a0265848-2496-d347-a40f-ce83e7dfd945@electromag.com.au>
 <2970055.FM06l9ul3d@dabox> <1510133354.25007.97.camel@linux.intel.com>
 <7abe16b1-4bfd-4427-8783-b3733ed9f06c@electromag.com.au>
Message-ID: <1510330329.25007.133.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-11-10 at 14:55 +0800, Phil Reid wrote:
> On 8/11/2017 17:29, Andy Shevchenko wrote:
> > On Wed, 2017-11-08 at 09:29 +0100, Tim Sander wrote:

> I'm not sure my change set will affect anything..
> Current drivers using the gpio functions are requesting the gpio using
> the old interface.
> If releasing the gpio doesn't restore the original functionality than
> nothing changes with this series.
> 
> For the designware driver, the recovery code wont be called unless the
> gpio's are specified via the device tree.
> So the pinmux config shouldn't get changed.
> 
> It'd be nice to have the code in mainline even if most soc's can't use
> it as yet.

I'm fine as long as it doesn't break existing users of DW I2C.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
