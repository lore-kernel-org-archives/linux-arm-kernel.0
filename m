From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 17 Feb 2011 09:53:56 -0200
Subject: [PATCH 16/17] mc13xxx: mfd_cell is now implicitly available to
	drivers
In-Reply-To: <20110216125820.GA22310@pengutronix.de>
References: <20110211181921.3d561568@queued.net>
	<20110216094154.GV13279@pengutronix.de>
	<4D5BC38E.1060009@freescale.com>
	<20110216125820.GA22310@pengutronix.de>
Message-ID: <AANLkTimhXR=AWT6wV-MXhtW7dvs6OYW7OqaV5RPhFP5V@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

2011/2/16 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> On Wed, Feb 16, 2011 at 10:31:10AM -0200, Fabio Estevam wrote:
>> Hi Uwe,
>>
>> On 2/16/2011 7:41 AM, Uwe Kleine-K?nig wrote:
>> ...
>> >> ?/* MC13783 */
>> >> -static struct mc13783_platform_data mc13783_pdata __initdata = {
>> > isn't using __initdata here broken already before your patch? ?Was
>> > introduced in c67a3e09. ?Fabio?
>>
>> I followed the same approach as in mx31_3ds.c file.
>>
>> > But in general I'd prefer to keep as much __initdata as possible because
>> > this occupies less memory when using a multi-machine kernel.
>>
>> Ok, is the __initdata usage correct then? If not, I can change it. Just let me know.
> I guess that if you compile mc13xxx support as module it won't work.
>
> Try that, and if it breaks, send a patch fixing mx31_3ds.c, too.

I built it as module and the build went fine.

Regards,

Fabio Estevam
