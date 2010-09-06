From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 6 Sep 2010 12:30:37 +0100
Subject: Colibri PXA320 Power management question
In-Reply-To: <AANLkTin3=pVMpSjtof_mLtMQGL-84qJZMCnfb-0xKfab@mail.gmail.com>
References: <AANLkTik_6ziPZwV9EuZwE4SMtJoc10JrBZZ_-mmsuy5a@mail.gmail.com>
	<20100902142203.GA8381@sirena.org.uk>
	<4C7FB7B5.2010301@compulab.co.il>
	<20100902152705.GC5809@rakim.wolfsonmicro.main>
	<4C7FC606.20904@compulab.co.il>
	<20100906101320.GD10367@rakim.wolfsonmicro.main>
	<AANLkTin3=pVMpSjtof_mLtMQGL-84qJZMCnfb-0xKfab@mail.gmail.com>
Message-ID: <20100906113036.GG10367@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 06, 2010 at 07:09:44PM +0800, Eric Miao wrote:
> On Mon, Sep 6, 2010 at 6:13 PM, Mark Brown

> > That'd be slightly entertaining, though, since IIRC the hardware
> > implementation isn't really set up for being constrained - it doesn't
> > expect to be cooperating with software governors.

> It doesn't need to. There is actually an internal command table, and
> not really sure about the mapping scheme though, but when software
> then has only to care about the frequencies, and voltages will be
> adjusted accordingly.

Ah, I'm misremembering the PXA implementation for the i.MX one - the
i.MX version of this feature had a governor rather than just doing a
lookup from the frequency to a voltage.
