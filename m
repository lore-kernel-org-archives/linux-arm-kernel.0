From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Oct 2011 20:41:04 +0200
Subject: [RFC PATCH] tty/serial: RS485 bindings for device tree
In-Reply-To: <4E947CA6.9010703@atmel.com>
References: <1318353208-24422-1-git-send-email-nicolas.ferre@atmel.com>
	<4E947CA6.9010703@atmel.com>
Message-ID: <3289709.mzRgbAUyPT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 October 2011 19:28:06 Nicolas Ferre wrote:
> 
> > +Optional properties:
> > +- linux,rs485-enabled-at-boot-time: empty property telling to enable the rs485
> > +  feature at boot time. It can be disabled later with proper ioctl.
> 
> +- linux,rs485-rx-during-tx: empty property that enable the receiving of data
> +  even whilst sending data.


This does not sound too linux specific. If it's a hardware property, don't
use the 'linux,' prefix and just make it 'rs484-full-duplex' or such.

	Arnd
