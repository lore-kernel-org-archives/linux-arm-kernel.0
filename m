From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 10 Sep 2009 20:35:51 +0800
Subject: What's inside the pxa tree for this merge window
In-Reply-To: <20090910123218.GV9410@buzzloop.caiaq.de>
References: <f17812d70909100446h17a1903fy74941945dbfc6943@mail.gmail.com>
	<20090910115439.GU9410@buzzloop.caiaq.de>
	<f17812d70909100523l5936e11bpd41354aed622d480@mail.gmail.com>
	<20090910123218.GV9410@buzzloop.caiaq.de>
Message-ID: <f17812d70909100535r36b62ad5r2c32e2dcecba0c93@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 10, 2009 at 8:32 PM, Daniel Mack <daniel@caiaq.de> wrote:
> On Thu, Sep 10, 2009 at 08:23:00PM +0800, Eric Miao wrote:
>> On Thu, Sep 10, 2009 at 7:54 PM, Daniel Mack <daniel@caiaq.de> wrote:
>> > Regarding the PXA3xx GCU driver:
>> >
>> > I really wonder what's wrong with the fbdev people to ignore my very
>> > simple patch for pxa3xx gcu enabling (not the gcu driver itself but just
>> > the acceleration ID registration), even after the fifth (or so)
>> > repost.
>> >
>>
>> Mmm... I don't actually see there is any problem with that patch. I can
>> take it if you are OK.
>
> Yes, please :) I thought you were mentioning you'd be needing an ACK
> from the fbdev people.
>

Yeah, but in case of no one Ack...

>> BTW: do you think CONFIG_PXA3xx_GCU is necessary around the
>> FB_ACCEL_PXA3xx assignment?
>
> Hmm, I'd say you don't want fb.fix.accel set unless the driver is
> enabled, right?
>

I'm not sure if it can be set anyway without the driver being
built. I mean - I don't want Kconfig option to cross modules.
