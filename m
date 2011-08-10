From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 10 Aug 2011 22:41:22 +0800
Subject: [PATCH] pxa/hx4700: Add Synaptics NavPoint (PXA27x SSP/SPI) driver
In-Reply-To: <1312972760.78921.YahooMailClassic@web29001.mail.ird.yahoo.com>
References: <CAMPhdO-PH2M-VyzqOHnUo7j54Ok8D=xuh1cX2F+KVL4fCkFKnw@mail.gmail.com>
	<1312972760.78921.YahooMailClassic@web29001.mail.ird.yahoo.com>
Message-ID: <CAMPhdO-6DeY69p3-DzNAbxqXJLRNso4hWji1OFifYYsdytL7mA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Are you implying that the hx4700 is acting as a SPI slave?
>
> Yes.
>
>> My original
>> understanding is hx4700 is communicating with an external
>> touchpad
>> controller through SPI? If hx4700 is acting as a SPI slave,
>> then it's true
>> there is no existing framework for that yet.
>
> That's correct; the NavPoint touchpad controller is the SPI master, Linux is the SPI slave.

That's really interesting. Grant, do you have any idea we have a SPI
slave API, or that we could actually re-use the existing SPI API for
that purpose?
