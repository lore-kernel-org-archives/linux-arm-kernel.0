From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Nov 2009 17:12:47 +0000
Subject: [patch 1/1] TOUCHSCREEN: S3C24XX touchscreen driver from
	Arnaud  Patard.
In-Reply-To: <20091119170321.GB15647@core.coreip.homeip.net>
References: <20091118232939.201290297@fluff.org.uk>
	<20091118232948.063635416@fluff.org.uk>
	<20091119025930.GA20172@core.coreip.homeip.net>
	<4B052D50.2070002@simtec.co.uk>
	<20091119135236.GB5535@digital-scurf.org>
	<20091119170321.GB15647@core.coreip.homeip.net>
Message-ID: <20091119171247.GB22232@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2009 at 09:03:21AM -0800, Dmitry Torokhov wrote:
> Why everyone thinks that it is a good idea to pile workarounds for
> software issues in the kernel but updating the other parts of software
> stack is a big no-no?

It's probably because pressing 'reset' and have your board TFTP the
new kernel straight from your development machine is far easier than
going through the hoops to regenerate a root filesystem and reflashing
it.

Note that I'm not condoning it, just pointing out why it happens.  And
yes, we must resist the temptation to merge such workarounds.
