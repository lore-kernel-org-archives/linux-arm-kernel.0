From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Fri, 2 Sep 2011 08:52:12 +0530
Subject: [RFC/PATCH v2 08/13] dt: omap: i2c: add dt support for i2c1
	controller
In-Reply-To: <4E5FC213.3080407@ti.com>
References: <1314074021-25186-1-git-send-email-manjugk@ti.com>
	<1314074021-25186-9-git-send-email-manjugk@ti.com>
	<20110823154649.GF32698@manju-desktop> <4E5FC213.3080407@ti.com>
Message-ID: <20110902032212.GC6465@manju-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

On Thu, Sep 01, 2011 at 07:34:11PM +0200, Cousson, Benoit wrote:
> Hi Manju,
> 
> On 8/23/2011 5:46 PM, G, Manjunath Kondaiah wrote:
> >Hi Grant,
> 
> [...]
> 
> >This function calls of_i2c_register_devices which attaches all the required
> >parameters reg, irq, archdata etc into i2c adapter. But it will not attach
> >platform_data which results empty pdata pointer in i2c child devices.
> >
> >Is this done purposefully?
> 
> I think so, but anyway, we'd rather spend some time on doing a
> proper DT implementation than hacking more the AUXDATA temporary
> solution.
> 
> I've just sent a reworked version of that series with a pure
> dt-no-auxdata-hack approach.

Thanks for initiating aux data cleanup series. Let us syncup on further changes
and follow up so that we can have this feature with v3.2 merge window.

Grant, Can you have a look and provide feedback on all the patches which are
done for omap dt work.

-M
