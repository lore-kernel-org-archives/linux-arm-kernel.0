From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 18 Jan 2011 09:19:33 +0100 (CET)
Subject: resume regression in 2.6.37
In-Reply-To: <4D349787.80201@metafoo.de>
References: <1294933492.2535.23.camel@sven>
	<alpine.LFD.2.00.1101131720350.2678@localhost6.localdomain6>
	<1294938961.10740.24.camel@sven>
	<alpine.LFD.2.00.1101131827080.2678@localhost6.localdomain6>
	<1295260580.2060.29.camel@sven>
	<alpine.LFD.2.00.1101171142380.2678@localhost6.localdomain6>
	<4D349787.80201@metafoo.de>
Message-ID: <alpine.LFD.2.00.1101180917340.6537@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

B1;2401;0cOn Mon, 17 Jan 2011, Lars-Peter Clausen wrote:
> If you take a look at the pxa gpio irq handling you'll see that it sets the
> "set_wake" field of it's irq_chip after calling set_irq_chip for all of the irqs, so
> the compat handler gets never installed.

Good catch. Can you please resend with a proper changelog and SOB?
Please add 

Cc: stable at kernel.org

after the Signed-off-by line.

Also feel free to add:

Acked-by: Thomas Gleixner <tglx@linutronix.de>
