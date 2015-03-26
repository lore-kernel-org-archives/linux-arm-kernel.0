From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 26 Mar 2015 16:41:29 +0100
Subject: [RFC 4/6] spi: atmel: use atmel_io.h to provide on-chip IO
In-Reply-To: <20150326153855.GP3572@sirena.org.uk>
References: <1427370354-21247-1-git-send-email-ben.dooks@codethink.co.uk>
 <1427370354-21247-5-git-send-email-ben.dooks@codethink.co.uk>
 <20150326153855.GP3572@sirena.org.uk>
Message-ID: <551428A9.9090604@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 26/03/2015 16:38, Mark Brown a ?crit :
> On Thu, Mar 26, 2015 at 11:45:52AM +0000, Ben Dooks wrote:
>> Use <linux/atmel_io.h> to provide IO accessors which work on both
>> AVR32 and ARM for on-chip peripherals.
> 
> To repeat the feedback on your previous big endian fix: I've not been
> CCed on the cover letter or any of the other patches so can someone tell
> me if there are any dependencies or anything?

Yes, there is dependency on a common header file. So I think we should
keep the series grouped or plan a migration path.

Bye,
-- 
Nicolas Ferre
