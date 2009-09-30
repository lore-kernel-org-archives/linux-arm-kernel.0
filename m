From: rubini-list@gnudd.com (Alessandro Rubini)
Date: Wed, 30 Sep 2009 18:41:03 +0200
Subject: list of apparently(?) un-included header files under arch/arm 
In-Reply-To: <alpine.LFD.2.00.0909301126360.18347@localhost>
References: <alpine.LFD.2.00.0909301126360.18347@localhost> 
Message-ID: <20090930164102.GA4128@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> ./arch/arm/mach-at91/include/mach/at91_adc.h
> ./arch/arm/mach-at91/include/mach/at91_spi.h
> ./arch/arm/mach-at91/include/mach/at91_ssc.h

These at least are useful. I've used the ADC some time ago, and not
having to redefine register is good. And when someone will write
corresponding drivers for the kernel, the header is already there.

I can't tell for the other platforms, though.

/alessandro
