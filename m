From: erikbenada@yahoo.ca (Erik Benada)
Date: Sun, 24 Jan 2010 19:05:15 -0800 (PST)
Subject: [PATCH] mach-orion5x: D-link DNS-323 rev. B1 power-off
In-Reply-To: <alpine.LFD.2.00.1001242151060.1681@xanadu.home>
References: <953961.24356.qm@web39605.mail.mud.yahoo.com>
	<alpine.LFD.2.00.1001242151060.1681@xanadu.home>
Message-ID: <248473.97169.qm@web39607.mail.mud.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

----- Original Message ----

> From: Nicolas Pitre <nico@fluxnic.net>
> To: Erik Benada <erikbenada@yahoo.ca>
> Cc: linux-arm-kernel at lists.infradead.org; Laurie Bradshaw <bradshaw.laurie@googlemail.com>; Martin Michlmayr <tbm@cyrius.com>
> Sent: Sun, January 24, 2010 9:54:01 PM
> Subject: Re: [PATCH] mach-orion5x: D-link DNS-323 rev. B1 power-off
> 
> On Sun, 24 Jan 2010, Erik Benada wrote:
> 
> > This patch fixes power LED blinking and power-off on DNS-323 rev. B1.
> > 
> > GPIO pin 3 has to be set to 1 to stop power LED blinking and to allow the LED 
> to be controlled via leds-gpio. This pin has to be also set to 1 for power-off 
> to work.
> > To power-off the rev. B1 machine, pin 8 has to be set to 1 and then set to 0 
> to do actual power-off.
> > 
> > Tested on my DNS-323 rev. B1
> > 
> > Signed-off-by: Erik Benada 
> 
> What is this patch based on?  I get only rejects when trying to apply it.
> 
> 
> Nicolas


It's based on latest Linus's tree. Maybe Yahoo messed up in-line code... Have you tried the attachment?

Erik


      __________________________________________________________________
Looking for the perfect gift? Give the gift of Flickr! 

http://www.flickr.com/gift/
