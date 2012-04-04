From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Apr 2012 14:08:03 +0100
Subject: linux-3.4-rc1 PXA2xx PCMCIA possible regression
In-Reply-To: <1333504642.26202.YahooMailClassic@web29009.mail.ird.yahoo.com>
References: <1333504642.26202.YahooMailClassic@web29009.mail.ird.yahoo.com>
Message-ID: <20120404130803.GV24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 04, 2012 at 02:57:22AM +0100, Paul Parsons wrote:
> On linux-3.3 the PCMCIA/CF on my hx4700 worked OK.
> 
> On linux-3.4-rc1 the PCMCIA/CF has stopped working:
> 
> pcmcia_socket pcmcia_socket0: pccard: PCMCIA card inserted into slot 0
> pcmcia 0.0: pcmcia: registering new device pcmcia0.0 (IRQ: 156)
> pata_pcmcia: probe of 0.0 failed with error -12

I see no PCMCIA support for HX4700 in mainline.  Where is it?
