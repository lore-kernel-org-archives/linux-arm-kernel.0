From: nils.faerber@kernelconcepts.de (Nils Faerber)
Date: Thu, 28 Oct 2010 21:56:59 +0200
Subject: New Kirkwood board support
In-Reply-To: <20101028194306.GL3122@n2100.arm.linux.org.uk>
References: <4CC9C245.3030906@kernelconcepts.de>	<20101028190133.GC31158@pengutronix.de>	<4CC9D0A3.70204@kernelconcepts.de>
	<20101028194306.GL3122@n2100.arm.linux.org.uk>
Message-ID: <4CC9D58B.5040006@kernelconcepts.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 28.10.2010 21:43, schrieb Russell King - ARM Linux:
> On Thu, Oct 28, 2010 at 09:36:03PM +0200, Nils Faerber wrote:
>> +MACHINE_START(TK71, "TK71 Kirkwood based Q7 formfactor board")
>> +	/* Maintainer: Nils Faerber <nils.faerber@kernelconcepts.de> */
>> +	.phys_io	= KIRKWOOD_REGS_PHYS_BASE,
>> +	.io_pg_offst	= ((KIRKWOOD_REGS_VIRT_BASE) >> 18) & 0xfffc,
> 
> The reason you don't want this is because these have been removed
> during this merge window already, so merging this code as-is into
> current mainline won't build.

Ah, I see, so this still valid for 2.6.36 (which I have in my tree) but
not for upcoming 2.6.37? OK, this makes perfect sense.
Then I have to get myself a more recent tree first so that I can make a
patch against it - it looks to me that I just have to remove those two
and everything is shiny again ;)
I will do so tomorrow.

Cheers
  nils

-- 
kernel concepts GbR        Tel: +49-271-771091-12
Sieghuetter Hauptweg 48
D-57072 Siegen             Mob: +49-176-21024535
http://www.kernelconcepts.de
