From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Wed, 20 Oct 2010 10:00:14 +0200
Subject: [PATCH] Documentation about RS485 serial communications
In-Reply-To: <i9kk4o$svc$1@dough.gmane.org>
References: <20100408111310.524f7354@lxorguk.ukuu.org.uk>
	<201010191727.53314.alexander.stein@systec-electronic.com>
	<i9kk4o$svc$1@dough.gmane.org>
Message-ID: <201010201000.14905.alexander.stein@systec-electronic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 October 2010, 19:22:32 Grant Edwards wrote:
> Yes, the AT91 UARTs do have a built-in half-duplex mode that will
> automatically control line direction by toggling RTS.
> 
> That can used to control external half-duplex hardware like an RS485
> transceiver or any RS232-connected half-duplex device like some
> modems.
> 
> Though the Atmel docs refer to it as "RS485 mode" there is no RS485
> transceiver in the AT91 parts (AFAIK), and "RS485 mode" isn't specific
> to RS485 - it can be used with any external half-duplex hardware.

Out of curiosity, how can I add RS485 (or whatever) support for other serial 
devices like e.g. i.mx serial? Is there some driver independent interface 
which only gets filled in board configs like setting some GPIO pins?

Alexander
