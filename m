From: khilman@ti.com (Kevin Hilman)
Date: Mon, 06 Jun 2011 15:50:55 -0700
Subject: TI-Davinci 6446 oops on interrupts
In-Reply-To: <alpine.LFD.2.02.1106062330380.13964@ionos> (Thomas Gleixner's
	message of "Mon, 6 Jun 2011 23:31:31 +0200 (CEST)")
References: <4DECCADE.6080100@selfish.org> <4DECD8C0.6010908@freyther.de>
	<alpine.LFD.2.02.1106061650210.13964@ionos>
	<4DECEDF9.4010202@selfish.org>
	<alpine.LFD.2.02.1106061719290.13964@ionos>
	<4DECF32B.6000508@selfish.org>
	<alpine.LFD.2.02.1106062330380.13964@ionos>
Message-ID: <87y61evak0.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Gleixner <tglx@linutronix.de> writes:

> Kevin,
>
> On Mon, 6 Jun 2011, Holger Freyther wrote:
>
>> On 06/06/2011 05:25 PM, Thomas Gleixner wrote:
>> 
>> > Crap, yes. The code which does the chained handler setup overwrites
>> > chip_data.
>> > 
>> 
>> Ah, you were too fast in the end, I just finished reading linux/irq.h. :)
>> 
>> 
>> 
>> > Subject: arm: davinci: Fix fallout from generic irq chip conversion
>> > From: Thomas Gleixner <tglx@linutronix.de>
>> > Date: Mon, 06 Jun 2011 11:51:43 +0200
>> > 
>> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> 
>> Tested-by: Holger Hans Peter Freyther <holger@freyther.de>
>
> can you please pick that up? It should have a Cc: stable at kernel.org
> tag as well.

Yup, will do.

Thanks,

Kevin
