From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 14 Mar 2017 22:11:46 +0100
Subject: [BUG] dmaengine: pxa_dma: + mmc: pxamci: race condition with DMA
 error on tx channel
In-Reply-To: <feb39d00-d40d-f935-751c-8119f40b4df4@tul.cz> (Petr Cvek's
 message of "Fri, 10 Mar 2017 01:49:12 +0100")
References: <e749aff1-0ffc-c9ed-42b2-82397b4e8ba2@tul.cz>
 <877f3zwwgo.fsf@belgarion.home>
 <feb39d00-d40d-f935-751c-8119f40b4df4@tul.cz>
Message-ID: <871stzh8bx.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

Ok Petr, I've been trying for days to reproduce without any luck.

I had a look at your traces, and I'd like something else when it happens :
 1) The patch I provided earlier applied
 2) This done (the 'cat' after the bug) :
	mount -t debugfs none /sys/kernel/debug/
	cat /sys/kernel/debug/pxa-dma.0/channels/4/[sd]*

Cheers.

--
Robert
