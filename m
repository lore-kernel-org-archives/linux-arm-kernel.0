From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sat, 12 Jun 2010 15:10:49 +1000
Subject: [RFC,PATCH 1/2] Add a common struct clk
In-Reply-To: <19473.61547.684572.647641@ipc1.ka-ro>
References: <1275636608.606606.450179637764.0.gpush@pororo>
	<1275636608.607067.417709988883.1.gpush@pororo>
	<20100611042046.GA31045@fluff.org.uk>
	<201006111557.12249.jeremy.kerr@canonical.com>
	<19473.61547.684572.647641@ipc1.ka-ro>
Message-ID: <1276319449.1962.178.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Using a mutex in clk_enable()/clk_disable() is a bad idea, since that
> makes it impossible to call those functions in interrupt context.

And doing clk_enable/clk_disable from interrupt context is a bad idea as
well :-)

Cheers,
Ben.
