From: lost.distance@yahoo.com (Paul Parsons)
Date: Wed, 4 Apr 2012 14:55:21 +0100 (BST)
Subject: linux-3.4-rc1 PXA2xx PCMCIA possible regression
In-Reply-To: <20120404130803.GV24211@n2100.arm.linux.org.uk>
Message-ID: <1333547721.81557.YahooMailClassic@web29008.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

--- On Wed, 4/4/12, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Wed, Apr 04, 2012 at 02:57:22AM
> +0100, Paul Parsons wrote:
> > On linux-3.3 the PCMCIA/CF on my hx4700 worked OK.
> > 
> > On linux-3.4-rc1 the PCMCIA/CF has stopped working:
> > 
> > pcmcia_socket pcmcia_socket0: pccard: PCMCIA card
> inserted into slot 0
> > pcmcia 0.0: pcmcia: registering new device pcmcia0.0
> (IRQ: 156)
> > pata_pcmcia: probe of 0.0 failed with error -12
> 
> I see no PCMCIA support for HX4700 in mainline.? Where
> is it?

It is languishing in pending patch land:

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-March/089266.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-March/088988.html

Regards,
Paul
