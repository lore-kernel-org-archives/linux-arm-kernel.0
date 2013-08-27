From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 27 Aug 2013 17:15:49 +0100
Subject: [PATCH 09/33] ARM: ux500: Supply the I2C clocks lookup to the
 DBX500 DT
In-Reply-To: <CAL_JsqJU6HA46J2HBRFaOgd_23d4UoLuGtMZYKtsZR1+7brKvg@mail.gmail.com>
References: <20130820093034.GL31036@pengutronix.de>
 <20130822133730.GB23152@e106331-lin.cambridge.arm.com>
 <20130822141900.GB17154@lee--X1>
 <20130822151723.GE23152@e106331-lin.cambridge.arm.com>
 <20130822154116.GC17154@lee--X1>	<20130822211912.GE31036@pengutronix.de>
 <20130823075607.GD17154@lee--X1>
 <20130823165539.GD7015@e106331-lin.cambridge.arm.com>
 <20130827080635.GC6152@lee--X1>
 <20130827134621.GJ19893@e106331-lin.cambridge.arm.com>
 <20130827140805.GB10210@lee--X1>
 <CAL_JsqJU6HA46J2HBRFaOgd_23d4UoLuGtMZYKtsZR1+7brKvg@mail.gmail.com>
Message-ID: <1377620149.6308.28.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-08-27 at 16:51 +0100, Rob Herring wrote:
> >> * pl111 has no driver or binding in mainline, but appears in dts files.
> >>   Those dts files clcdclk and apb_pclk, in that order. We could fix
> >>   those before a driver starts using them.
> 
> I think this was waiting for some generic display bindings? Pawel may know.

Common Display Framework it was ;-)

And yes, it was waiting for it, but it is getting bored with waiting so
I'll cut off the CDF bits and post the rest this or next week.

As to the APB clock, we've been there before...
http://article.gmane.org/gmane.linux.ports.arm.kernel/188927

Cheers!

Pawel
