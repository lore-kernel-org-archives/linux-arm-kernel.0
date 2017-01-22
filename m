From: alexanders83@web.de (Alexander Stein)
Date: Sun, 22 Jan 2017 09:52:05 +0100
Subject: ARM64: Disabling warnings about deprecated armv8 instructions
In-Reply-To: <1485072424.14066.2.camel@crowfest.net>
References: <1485072424.14066.2.camel@crowfest.net>
Message-ID: <9647813.NZ2c5cYUSH@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

On Sunday, January 22, 2017, 12:07:04 AM CET Michael Zoran wrote:
> I'm not sure if this if the correct place to be asking this.   The RPI
> 3 running ARM64 is slowly reaching the point of being about to
> seriously run a 32 bit vender OS like Raspbian.  When running Raspbian,
> I'm seeing a very large number(thousands) of kernel log messages about
> deprecated instructions especially setend and barrier instuctions.
> This can be very annoying and is completely filling the kernel log.
> 
> I'm considering submitting a patch to add a Kconfig option to disable
> these warnings with the default being to keep the warnings enabled.  I
> was wondering if such a patch could be seriously considered.

Could you please provide an example of those warning an what is trigging 
those?

Thanks and best regards,
Alexander
