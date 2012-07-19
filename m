From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Jul 2012 08:55:07 +0000
Subject: [RFC PATCHv5] ARM: socfpga: initial support for Altera's SOCFPGA
 platform
In-Reply-To: <20120719093231.72f2871d@skate>
References: <1342649238-1044-1-git-send-email-dinguyen@altera.com>
 <1342649238-1044-2-git-send-email-dinguyen@altera.com>
 <20120719093231.72f2871d@skate>
Message-ID: <201207190855.08225.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 19 July 2012, Thomas Petazzoni wrote:
> Le Wed, 18 Jul 2012 16:07:18 -0600,
> <dinguyen@altera.com> a ?crit :
> 
> > From: Dinh Nguyen <dinguyen@altera.com>
> > 
> > Adding core definitions for Altera's SOCFPGA ARM platform.
> > Mininum support for Altera's SOCFPGA Cyclone 5 hardware.
> > 
> > Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> > Reviewed-by: Pavel Machek <pavel@denx.de>
> > Reviewed-by: Rob Herring <rob.herring@calxeda.com>
> 
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thanks everyone!

I've applied it to the next/newsoc branch now.
I fixed up a little whitespace damage in the dts file that git-am
complained about, and I put the arch/arm/Makefile entry into
alphabetical order again before applying.

	Arnd
