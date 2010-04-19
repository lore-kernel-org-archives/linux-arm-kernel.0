From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue, 20 Apr 2010 07:38:34 +1200
Subject: ep93xx SPI driver v3
In-Reply-To: <20100419064809.GF19534@gw.healthdatacare.com>
References: <20100415173905.GJ2685@gw.healthdatacare.com>
	<j2u56d259a01004151645y47ec8254ree59189aaa6b5baa@mail.gmail.com>
	<20100416042658.GK2685@gw.healthdatacare.com>
	<l2p56d259a01004160211m17bc0f10gc63a5ca82436c8e3@mail.gmail.com>
	<20100416094444.GC6718@gw.healthdatacare.com>
	<p2l56d259a01004160455jdf290557yd102cf78d9f1252e@mail.gmail.com>
	<20100416171032.GD6718@gw.healthdatacare.com>
	<r2j56d259a01004162023tdf8f226aw5aab98bd54c03ac0@mail.gmail.com>
	<4BCB7148.5040600@bluewatersys.com>
	<20100419064809.GF19534@gw.healthdatacare.com>
Message-ID: <4BCCB13A.50807@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mika Westerberg wrote:
> On Mon, Apr 19, 2010 at 08:53:28AM +1200, Ryan Mallon wrote:
>> Martin Guy wrote:
>>> If we can get that working, a reasonable second stage would make it
>>> work for ep93xx-SPI transfers, making SD card access even less
>>> CPU-intensive
>> Sine the M2M DMA support for the ep93xx is not in the mainline yet, I
>> would be happy for the SPI driver to be merged without DMA support, and
>> to have it added at a later date.
> 
> Yeah. This discussion actually referred to future improvements. We
> can implement DMA support later on.
> 
> BTW: do you guys think that there is any real use of polling mode
> in the driver or should I drop it out completely? I mean, if we are
> going to add proper timeout / error reporting for polling, it makes
> the driver more complex.

I recall not being able to get interrupt mode working in the driver the
Hartley and I worked on. I can't remember if this was a limitation of
our hardware, or just bugs in the interrupt code. I'll try and find some
time today to test the driver out.

~Ryan
