From: rogerq@ti.com (Roger Quadros)
Date: Tue, 6 Aug 2013 10:38:31 +0300
Subject: [PATCH v10] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <20130805153516.GC13091@e106331-lin.cambridge.arm.com>
References: <1374139586-6344-1-git-send-email-p.zabel@pengutronix.de>
 <20130802092823.GA2884@e106331-lin.cambridge.arm.com>
 <1375687936.4000.21.camel@pizza.hi.pengutronix.de>
 <20130805153516.GC13091@e106331-lin.cambridge.arm.com>
Message-ID: <5200A7F7.6080104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 08/05/2013 06:35 PM, Mark Rutland wrote:
> On Mon, Aug 05, 2013 at 08:32:16AM +0100, Philipp Zabel wrote:
>> Hi Mark,
> 
> Hi Philipp,
> 
>>
>> Am Freitag, den 02.08.2013, 10:28 +0100 schrieb Mark Rutland:

> 
> I'm not sure about initially-in-reset. Is it not possible for the driver
> to poke the GPIO controller to ensure the GPIOs are in the state
> required?

We need initially-in-reset, so that the device can be kept in reset even
when the device driver is not available or loaded late in the boot cycle.

cheers,
-roger
