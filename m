From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Tue, 19 Oct 2010 17:27:27 +0200
Subject: [PATCH] Documentation about RS485 serial communications
In-Reply-To: <i9ka0s$4ua$1@dough.gmane.org>
References: <20100408111310.524f7354@lxorguk.ukuu.org.uk>
	<4CBD8EE4.5040808@evidence.eu.com> <i9ka0s$4ua$1@dough.gmane.org>
Message-ID: <201010191727.53314.alexander.stein@systec-electronic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 October 2010, 16:29:48 Grant Edwards wrote:
> On 2010-10-19, Claudio Scordino <claudio@evidence.eu.com> wrote:
> > +2. HARDWARE-RELATED CONSIDERATIONS
> > +
> > +   Some CPUs (e.g., Atmel AT91) contain a transceiver capable of working
> > both +   as RS232 and RS485.
> 
> Pardon my curiosity, but I've looked at a few AT91 parts, and I've
> never seen on with an internal transceiver -- nor does Google seem
> able to find any.
> 
> Frankly, I'd be pretty surprised, since it would be very difficult
> (fab-wise), to build a mircoprocessor with I/O cells capable of
> withstanding the voltage levels specified in RS232.
> 
> Can you specify to which parts you're referring?

I doubt the AT91 do have an internal transceiver but it has a dedicated pin 
feature (RTS or CTS or something) which can be used to switch between RS232 
and RS485 by setting a bit in the USART provided the pin is connected 
properly.

Regards,
Alexander
