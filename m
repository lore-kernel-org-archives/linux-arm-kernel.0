From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 14 Apr 2010 09:31:38 +0200
Subject: [PATCH 2.6.34-rc4 1/8] mx5: Add registration of GPIOs for MX51
	Babbage board.
In-Reply-To: <20100414065131.GD7882@pengutronix.de>
References: <1271175030-3635-1-git-send-email-Dinh.Nguyen@freescale.com>
	<20100413164532.GM30801@buzzloop.caiaq.de>
	<86A0E76937111F4C92FABEC0A2098851046C7A62@az33exm21>
	<20100414065131.GD7882@pengutronix.de>
Message-ID: <20100414073138.GZ30801@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 14, 2010 at 08:51:31AM +0200, Sascha Hauer wrote:
> On Tue, Apr 13, 2010 at 12:36:07PM -0700, Nguyen Dinh-R00091 wrote:
> > > +
> > > +#ifdef MXC_GPIO_SPLIT_IRQ_2
> > 
> > Where is that macro defined?
> > [Dinh-FSL] - This macro is optional so that the interrupts can be broken
> > up into 2 sets.
> 
> What's the purpose of doing so?
> 
> Such compile time depencies are not a good idea since the board may want
> to decide whether to split the interrupts or not. Note that we support
> kernels for more than one board.

And I would have expected at least one active user. As it stands, it's
just dead code.

Daniel
