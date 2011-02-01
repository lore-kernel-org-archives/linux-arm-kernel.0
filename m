From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 01 Feb 2011 17:25:56 +0000
Subject: [PATCH] arm: Improve MMC performance on Versatile Express
In-Reply-To: <AANLkTimEBz6UK0X45cA2ihZddfcSTNqEPTJa=zGc+84S@mail.gmail.com>
References: <1295618352-26432-1-git-send-email-pawel.moll@arm.com>
	<alpine.LFD.2.00.1101211456200.8580@xanadu.home>
	<20110121215110.GD23151@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101211655110.8580@xanadu.home>
	<20110121222930.GF23151@n2100.arm.linux.org.uk>
	<AANLkTimEBz6UK0X45cA2ihZddfcSTNqEPTJa=zGc+84S@mail.gmail.com>
Message-ID: <1296581156.2768.58.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Have you considered switching the ISP1761 handler to
> request_threaded_irq() with IRQF_ONESHOT | IRQF_NO_SUSPEND
> so it runs in process context with that IRQ masked off, until completion?

That's something that Will suggested, but no - I didn't try it. This may
be worth discussing with the ISP1761 driver maintainer...

Cheers!

Pawe?
