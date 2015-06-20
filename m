From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 20 Jun 2015 16:36:09 +0200
Subject: Linkstation Mini and __machine_arch_type problem, not booting
 since 3.8
In-Reply-To: <1434760119.5177.6.camel@dolka.fr>
References: <97db3502cd014faf1c710b1cc0fe8848@dolka.fr>
 <55827D64.1090307@free-electrons.com>
 <1434678624.4767.22.camel@dolka.fr>
 <5583E1D9.2010002@free-electrons.com>
 <20150619114152.GA2936@io.lakedaemon.net>
 <1434760119.5177.6.camel@dolka.fr>
Message-ID: <20150620143609.GE1116@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > SERIAL_OF_PLATFORM?
> 
> Oh, and that was it!

This used to catch us all out a lot. What configuration are you using?
orion5x_defconfig? Very likely a patch adding it to that would be
accepted.

	Andrew
