From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Wed, 21 Oct 2009 23:40:20 +0200
Subject: [PATCH 2/4] [MXC] Armadillo500 Correct bus length for SMSC9118
	on board chip.
In-Reply-To: <20091019142757.GL8818@pengutronix.de>
References: <20091015191325.74ba24fb@Marramao-laptop>
	<20091015192451.50ee35c5@Marramao-laptop>
	<20091015192905.2fa228f9@Marramao-laptop>
	<20091019142757.GL8818@pengutronix.de>
Message-ID: <20091021234020.7cb33508@Marramao-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il giorno Mon, 19 Oct 2009 16:27:57 +0200
Sascha Hauer <s.hauer@pengutronix.de> ha scritto:

> Hi Alberto,
> 
> On Thu, Oct 15, 2009 at 07:29:05PM +0200, Alberto Panizzo wrote:
> > Armadillo500 Correct bus length for SMSC9118 on board chip.
> > 
> > The SMSC9118 network chip is connected to the data bus with a 16 bit
> > interface, not 32 as early suggested.  
> 
> This one looks like it should go into 2.6.32, right?
> 
> The other patches are ok. Please let me know what I should do with this
> one.
> 
> Sascha

If it is possible, yes thanks.

Alberto.
