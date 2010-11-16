From: matts@commtech-fastcom.com (Matt Schulte)
Date: Tue, 16 Nov 2010 12:41:14 -0600
Subject: [PATCH] Documentation about RS485 serial communications
In-Reply-To: <ibubf5$ev$1@dough.gmane.org>
References: <20100408111310.524f7354@lxorguk.ukuu.org.uk>
	<4CBD8EE4.5040808@evidence.eu.com> <i9ka0s$4ua$1@dough.gmane.org>
	<201010191727.53314.alexander.stein@systec-electronic.com>
	<i9kk4o$svc$1@dough.gmane.org> <4CC418A9.6090602@evidence.eu.com>
	<4CDA630F.4060903@atmel.com> <20101110172842.GC12371@suse.de>
	<4CDBC3EC.6020707@evidence.eu.com> <20101116143016.GB6527@ucw.cz>
	<AANLkTi=grehSnfWzCDtSXXmNb=-NAwbHHJ_P1XPyOuw8@mail.gmail.com>
	<ibubf5$ev$1@dough.gmane.org>
Message-ID: <AANLkTimio1aBh5w616eSikW+dujV-G8_pu-AT=B5e-7Y@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 16, 2010 at 10:28 AM, Grant Edwards
<grant.b.edwards@gmail.com> wrote:
> On 2010-11-16, Matt Schulte <matts@commtech-fastcom.com> wrote:
>> On Tue, Nov 16, 2010 at 8:30 AM, Pavel Machek <pavel@ucw.cz> wrote:
>>> Hi!
>>>
>>>> Documentation about RS485 serial communications
>>>
>>> I have seen hardware (kontron pmc-6l) that was capable of switching
>>> between RS232, RS485 and one other standard by software.
>>>
>>> Is such hw common? If so, should we have standard interface?
>>
>> In my opinion this type of card is not that common. ?Generally
>> speaking the achievable baud rates for this type of multi-protocol
>> card are very limited because of limitations of the transceiver chips.
>
> I'm curious which selectable interface cards you're talking about that
> are slow? ?The ones I'm familiar with generally support baud rates up
> to either 460K bps or 921K bps
>
>> It seems that most of the time people would rather have a faster
>> serial port than one that does several different voltages.
>
> Where did you find a selectable interface serial card that couldn't
> support high baud rates?

In my world 460kbps for an RS422 card is slow.  RS422 cards generally
push multi megabit/s rates.

Matt Schulte
