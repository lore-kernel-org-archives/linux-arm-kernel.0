From: hpa@zytor.com (H. Peter Anvin)
Date: Wed, 15 Jun 2011 08:08:05 -0700
Subject: [RFC,PATCH] Cleanup PC parallel port Kconfig
In-Reply-To: <20110615074749.GB28989@n2100.arm.linux.org.uk>
References: <20110614190850.GA13526@linux-mips.org>
	<4DF7C3CA.9050902@zytor.com> <201106142333.16203.arnd@arndb.de>
	<4DF83577.6040903@zytor.com>
	<20110615074749.GB28989@n2100.arm.linux.org.uk>
Message-ID: <4DF8CAD5.1090902@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/15/2011 12:47 AM, Russell King - ARM Linux wrote:
>>
>> OK, serial-8250 is clearly just plain wrong, since the 8250 series UARTs
>> are ubiquitous across just about every platform.
>>
>> Floppy is special (in the short bus sense), since it is closely tied to
>> ISA DMA.  Conditionalizing this on ISA DMA makes total sense.
> 
> No it doesn't.  It depends on the ISA DMA API, not that the machine has
> ISA DMA.
> 
> I have a platform which has no ISA DMA but uses the floppy driver.  Please
> don't break it.

OK, even more case in point, then.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
