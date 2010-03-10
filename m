From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 10 Mar 2010 17:56:11 +0000
Subject: [PATCH 2.6.34] ARM: SAMSUNG: Fix build after "ARM: Eliminate
	decompressor -Dstatic= PIC hack"
In-Reply-To: <20100310174650.GD12345@n2100.arm.linux.org.uk>
References: <1267469542-19633-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20100310171736.GJ6850@sirena.org.uk>
	<20100310172503.GB12345@n2100.arm.linux.org.uk>
	<20100310174228.GA5060@rakim.wolfsonmicro.main>
	<20100310174650.GD12345@n2100.arm.linux.org.uk>
Message-ID: <20100310175611.GA5403@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 10, 2010 at 05:46:50PM +0000, Russell King - ARM Linux wrote:

> Let's do the job properly this time then and put a declaration in
> compressed/misc.c

I agree that that's best, I guess I'll try to take a look.  I'd be much
more comfortable doing that in .35 than .34, though.
