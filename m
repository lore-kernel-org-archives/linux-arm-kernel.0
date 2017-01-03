From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 3 Jan 2017 14:12:56 +0100
Subject: [PATCH v3 2/3] DT: bingdings: power: reset: add
 linkstation-reset doc
In-Reply-To: <519e07d0-9b73-4445-ec5e-7ea2cbc1b814@gmail.com>
References: <20161216100501.18173-1-rogershimizu@gmail.com>
 <20161227070611.14852-1-rogershimizu@gmail.com>
 <20161227070611.14852-3-rogershimizu@gmail.com>
 <519e07d0-9b73-4445-ec5e-7ea2cbc1b814@gmail.com>
Message-ID: <20170103131256.GB30197@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +
> > +Required Properties:
> > +- compatible: Should be "linkstation,power-off"
> > +- reg: Address and length of the register set for UART1
> 
> Humm, should we instead have a phandle to the uart1 node?

Probably. Again, this is to do with copying the QNAP driver. I was
young, new to device tree, and i just did a logical conversion of the
existing code, and did not at the time understand phandles, etc.

	 Andrew
